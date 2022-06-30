//
//  ProfileViewController.swift
//  ShareAway
//
//  Created by Dmitry Ovchinikov on 29/06/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
        
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uniqueFirebaseID = Auth.auth().currentUser!.uid
        getFirebaseUser(uniqueFirebaseID)
    }
    
    func setupUI(_ name: String, _ phoneNumber: String, _ email: String) {
        nameLabel.text = name
        phoneNumberLabel.text = phoneNumber
        emailLabel.text = email
    }
    
    func getFirebaseUser(_ uid: String) {
        print("UID: " + uid)
        let db = Firestore.firestore()
        db.collection("users").getDocuments() { (snapshot, err) in
                if let err = err {
                    print("Error fetching the documents: \(err)")
                } else {
                    for document in snapshot!.documents {
                        let tempUID = document["uniqueID"] as! String
                        if( tempUID == uid ) {
                            let name = document["firstName"] as! String
                            let lastName = document["lastName"] as! String
                            let merged = name + " " + lastName
                            self.setupUI( merged, document["phoneNumber"] as! String, document["email"] as! String)
                        }
                    }
                }
        }
    }
    
    
    @IBAction func onButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
