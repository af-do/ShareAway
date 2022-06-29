//
//  LoginViewController.swift
//  ShareAway
//
//  Created by Dmitry Ovchinikov on 29/06/2022.
//
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
    }
    
    func setupUI() {
        Utilities.styleTextField(emailField)
    }
    
    func setupDelegates() {
        self.emailField.delegate = self
        self.passwordField.delegate = self
    }
    
    @IBAction func onLoginButtonPressed(_ sender: Any) {
        let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                let alert = Utilities.createAlert("Login failed!", "Please check your login information!")
                self.present(alert, animated: true, completion: nil)
            }
            else {
                if let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                    self.navigationController?.pushViewController(homeViewController, animated: true)
                }
            }
        }
    }
    
    @IBAction func onRegisterButtonPressed(_ sender: Any) {
        if let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
            self.navigationController?.pushViewController(registerViewController, animated: true)
        }
}
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.emailField:
            self.passwordField.becomeFirstResponder()
        case self.passwordField:
            self.passwordField.resignFirstResponder()
        default:
            self.resignFirstResponder()
        }
    }
}
