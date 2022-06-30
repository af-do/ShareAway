//
//  ShareViewController.swift
//  ShareAway
//
//  Created by Dmitry Ovchinikov on 29/06/2022.
//

import UIKit
import FirebaseFirestore

class ShareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var SharedItemsTableView: UITableView!
//
//    @IBOutlet weak var uploadPost: UIButton!
//
    var items = [SharedItem]()
//
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchItems()

        //let nib = UINib(nibName: "PostsTableViewCell" , bundle: nil)
        SharedItemsTableView.register(SharedItemTableViewCell.self, forCellReuseIdentifier: "SharedItemViewCell")
        SharedItemsTableView.delegate = self
        SharedItemsTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SharedItemsTableView.dequeueReusableCell(withIdentifier: "SharedItemsTableView", for: indexPath) as! SharedItemTableViewCell

        let db = Firestore.firestore()
        db.collection("users").whereField("uniqueID", isEqualTo: items[indexPath.row].itemSharerID).getDocuments() { (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in snapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let name = document["firstName"] as! String
                        let lastName = document["lastName"] as! String
                        let merged = name + " " + lastName
                        cell.itemName.text = merged
//                        cell.profileImage.image = LetterAvatarMaker().setUsername(document["name"] as! String).setBackgroundColors([.random()]).build()
                        //cell.profileImage.setRounded()
                    }
                }
            }

        cell.itemDate.text = items[indexPath.row].itemUploadDate
        cell.itemDescription.text = items[indexPath.row].itemDescription

        return cell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func fetchItems() {
        let db = Firestore.firestore().collection("sharedItemsList")
        db.addSnapshotListener { snapshot, error in
            if let err = error {
                print("fetchItems Error: \(err)")
            } else {
                guard let snap = snapshot else {
                    return
                }
                for document in snap.documents {
                    let item = SharedItem(itemName: document["itemName"] as! String, itemUploadDate: document["itemUploadDate"] as! String, itemDescription: document["itemDescription"] as! String, itemSharerID: document["itemSharerID"] as! String)
                    if (!self.items.contains(where: {$0.itemName == item.itemName})){
                        self.items.append(item)
                    }
                }
                DispatchQueue.main.async {
                    self.SharedItemsTableView.reloadData()
                }
            }
        }
    }
    
}
