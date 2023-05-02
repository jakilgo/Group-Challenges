//
//  ProfileViewModel.swift
//  Group Challenges
//
//  Created by Justin Kilgo on 5/1/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


class DailyData: ObservableObject {
    var date: String
    var steps: Int
    var bonusExercise: Int
    var medExercise: Int
    var shortExercise: Int
    var minWater: Bool
    
    func getPrint () -> String {
        return date
    }
    
    init(date: String = "", steps: Int = 0, bonusExercise: Int = 0, medExercise: Int = 0, shortExercise: Int = 0, minWater: Bool = false) {
        self.date = date
        self.steps = steps
        self.bonusExercise = bonusExercise
        self.medExercise = medExercise
        self.shortExercise = shortExercise
        self.minWater = minWater
    }
}
class UserData {
    var name = ""
    var points = 0
    var days = [DailyData]()
}

class ListData: Identifiable {
    var uuid = UUID()
    var name: String
    var points: Int
    
    init(name: String, points: Int) {
        self.name = name
        self.points = points
    }
}

protocol RequestDelegate: AnyObject {
    func didUpdate (with state: UserData)
    func didUpdate (with state: [ListData])
}

class DataViewModel: ObservableObject {
    weak var delegate: RequestDelegate?
    @Published var profileState: UserData {
        didSet {
            self.delegate?.didUpdate (with: profileState)
        }
    }
    @Published var listState: [ListData] {
        didSet {
            self.delegate?.didUpdate(with: listState)
        }
    }
    
    @Published var isLoggedIn: Bool
    
    private var uid: String?
    private var listeners: [ListenerRegistration] = []
    
    let db  = Firestore.firestore()

    func updateProfile() {
        
        var currDays: [[String: Any]] = []
        for day in profileState.days {
            let currDay: [String: Any] = [
                "date": day.date,
                "steps": day.steps + 1,
                "bonusExercise": day.bonusExercise,
                "medExercise": day.medExercise,
                "shortExercise": day.shortExercise,
                "minWater": day.minWater
            ]
            currDays.append(currDay)
        }
        db.collection("Users").document(uid!).setData([
            "name": profileState.name,
            "points": profileState.points,
            "days": currDays
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func createListeners() {
        uid = Auth.auth().currentUser!.uid
        listeners.append(db.collection("Users").document(uid!)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                self.profileState.name = data["name"]! as! String
                self.profileState.points = data["points"]! as! Int
                self.profileState.days.removeAll()
                if (data["days"] != nil) {
                    let days = data["days"]! as! [[String: Any]]
                    for day in days {
                        let newDay = DailyData(
                            date: day["date"] as! String,
                            steps: day["steps"] as! Int,
                            bonusExercise: day["bonusExercise"] as! Int,
                            medExercise: day["medExercise"] as! Int,
                            shortExercise: day["shortExercise"] as! Int,
                            minWater: day["minWater"] as! Bool
                        )
                        self.profileState.days.append(newDay)
                    }
                } else {
                    self.profileState.days = [DailyData()]
                }
                print("Current data: \(data)")
            })
        listeners.append(db.collection("Users").order(by: "points", descending: true)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.listState.removeAll()
                let tmpList = documents.map { ($0["name"]! as! String, $0["points"]! as! Int) }
                for player in tmpList {
                    self.listState.append(ListData(name: player.0, points: player.1))
                }
            })
    }
    
    func removeListeners() {
        self.isLoggedIn = false
        self.uid = nil
        for listener in listeners {
            listener.remove()
        }
    }
    
    init() {
        self.profileState = UserData()
        self.listState = []
        self.uid = Auth.auth().currentUser?.uid
        self.isLoggedIn = (self.uid != nil)
    }
}
