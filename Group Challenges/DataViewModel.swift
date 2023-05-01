//
//  ProfileViewModel.swift
//  Group Challenges
//
//  Created by Justin Kilgo on 5/1/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class Data {
    var name: String
    var points: Int
    init() {
        name = ""
        points = 0
    }
}

protocol RequestDelegate: AnyObject {
    func didUpdate (with state: Data)
}

class DataViewModel: ObservableObject {
    weak var delegate: RequestDelegate?
    var state: Data {
        didSet {
            self.delegate?.didUpdate (with: state)
        }
    }
    
    let db  = Firestore.firestore()

    func updateProfile() {
        db.collection("Users").document(Auth.auth().currentUser!.uid).setData([
            "name": state.name,
            "points": state.points
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    init() {
        self.state = Data()
        db.collection("Users").document(Auth.auth().currentUser!.uid)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                self.state.name = data["name"]! as! String
                self.state.points = data["points"]! as! Int
                print("Current data: \(data)")
            }
    }
}
