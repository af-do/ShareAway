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

    var items = [SharedItem]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.SharedItemsTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchItems()

        SharedItemsTableView.register(UINib(nibName: SharedItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SharedItemTableViewCell.identifier)
        SharedItemsTableView.delegate = self
        SharedItemsTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SharedItemsTableView.dequeueReusableCell(withIdentifier: SharedItemTableViewCell.identifier, for: indexPath) as! SharedItemTableViewCell
        cell.delegate = self
        cell.populate(items[indexPath.row])
        return cell
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
                    let item = SharedItem(itemName: document["itemName"] as? String, itemUploadDate: document["itemUploadDate"] as? String, itemDescription: document["itemDescription"] as? String, itemSharerID: document["itemSharerID"] as? String, imageBase64String: document["itemImage64Base"] as? String)
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

extension ShareViewController: SharedItemTableViewCellDelegate {
    func sharedItemTableViewCellPressedOnClaim(_ cell: SharedItemTableViewCell, item: SharedItem) {
        let db = Firestore.firestore()
        db.collection("users").whereField("uniqueID", isEqualTo: item.itemSharerID).getDocuments() { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    let phoneNumber = document["phoneNumber"] as? String
                    let alert = Utilities.createAlert("Seller phone number", phoneNumber ?? "")
                    self.items.removeAll(where: { $0.itemSharerID == item.itemSharerID && $0.itemName == item.itemName })
                    self.SharedItemsTableView.reloadData()
                    self.present(alert, animated: true)
                }
            }
        }
    }
}
