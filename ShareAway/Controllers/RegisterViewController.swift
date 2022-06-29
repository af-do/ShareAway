//
//  RegisterViewController.swift
//  ShareAway
//
//  Created by Dmitry Ovchinikov on 29/06/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
    }
    
    func setupDelegates() {
        self.firstNameField.delegate = self
        self.lastNameField.delegate = self
        self.phoneNumberField.delegate = self
        self.emailField.delegate = self
        self.passwordField.delegate = self
    }
    
    func setupUI() {
        Utilities.styleTextField(emailField)
    }
    
    @IBAction func onRegistrationButtonPressed(_ sender: Any) {
        
        let firstName = firstNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneNumber = phoneNumberField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //TODO: check fields
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if (error != nil) {
                let alert = Utilities.createAlert("Registration failed!", "Please check if all the fields are filled out and that the email is not previously registered.")
                self.present(alert, animated: true, completion: nil)
            } else {
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(
                    data:["firstName":firstName,"lastName":lastName, "phoneNumber":phoneNumber,"email":email,"password": password,"uniqueID": authResult!.user.uid ]) { (error) in
                    if error != nil {
                        print("error saving user data")
                    }
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.firstNameField:
            self.lastNameField.becomeFirstResponder()
        case self.lastNameField:
            self.phoneNumberField.becomeFirstResponder()
        case self.phoneNumberField:
            self.emailField.becomeFirstResponder()
        case self.emailField:
            self.passwordField.becomeFirstResponder()
        case self.passwordField:
            self.passwordField.resignFirstResponder()
        default:
            self.resignFirstResponder()
        }
    }
}
