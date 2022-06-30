//
//  UploadViewController.swift
//  ShareAway
//
//  Created by Dmitry Ovchinikov on 30/06/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var itemDescLabel: UILabel!
    @IBOutlet weak var itemDescField: UITextField!
    @IBOutlet weak var itemImageLabel: UILabel!
    
    var selectedImage64Base: String!
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func onShareButtonPressed(_ sender: Any) {
        if (itemNameField.text == nil) {
            let alert = Utilities.createAlert("Parameters missing!", "Please input the item's name!")
            present(alert, animated: true)
        } else if (itemDescField.text == nil) {
            let alert = Utilities.createAlert("Parameters missing!", "Please input the item's description!")
            present(alert, animated: true)
        } else if (selectedImage64Base == nil) {
            let alert = Utilities.createAlert("Parameters missing!", "Please choose a picture of the item!")
            present(alert, animated: true)
        } else {
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .short
            let currentTime = Date()
            
            db.collection("sharedItemsList").addDocument(data:["itemName": itemNameField.text, "itemDescription": itemDescField.text, "itemSharerID":user?.uid, "itemUploadDate":formatter.string(from: currentTime), "itemImage64Base": selectedImage64Base]) { (error) in
                if error != nil {
                    print("error happened while uploading item to DB" + error!.localizedDescription)
                }
            }
            
            let alert = Utilities.createAlert("Thank you!", "You just shared an item! A user will contact you via your phone number when the item is claimed!")
            present(alert, animated: true)
            itemNameField.text = ""
            itemDescField.text = ""
            
        }
    }
    
    @IBAction func onButtonPressed(_ sender: Any) {
        //upload image
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false

        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: { () -> Void in
            print("dismissing")
        })
        
        
        selectedImage64Base = image!.jpegData(compressionQuality: 0.1)?.base64EncodedString()
        //print("64Base: " + selectedImage64Base)
    }
}
