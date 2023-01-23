//
//  ViewController.swift
//  AlertRegister
//
//  Created by Konstantyn Koroban on 06/07/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var authorizationConditionLabel: UILabel!
    
    private var login: String?
    private var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizationConditionLabel.text = "You are not authorized"
        view.backgroundColor = .orange
    }
    
    @IBAction func showRegisterAlert(_ sender: Any) {
        let registerAlert = UIAlertController(title: nil, message: "Register new account", preferredStyle: .alert)
        let finishRegisterAlertButton = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: { _ in
                self.login = registerAlert.textFields![0].text
                self.password = registerAlert.textFields![1].text
            }
        )
        
        finishRegisterAlertButton.isEnabled = false
        registerAlert.addAction(finishRegisterAlertButton)
        
        registerAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        registerAlert.addTextField { loginTextField in
            loginTextField.placeholder = "Login"
            verifyRegistration(loginTextField)
            
        }
        
        registerAlert.addTextField { passwordTextField in
            passwordTextField.placeholder = "Password"
            passwordTextField.isSecureTextEntry = true
            verifyRegistration(passwordTextField)
        }
        
        registerAlert.addTextField { confirmPasswordTextField in
            confirmPasswordTextField.placeholder = "Confirm password"
            confirmPasswordTextField.isSecureTextEntry = true
            verifyRegistration(confirmPasswordTextField)
        }
        
        present(registerAlert, animated: true, completion: nil)
        
        func verifyRegistration(_ textField: UITextField) {
            NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: textField,
                queue: OperationQueue.main,
                using: { _ in
                    let loginText = registerAlert.textFields![0].text
                    let passwordText = registerAlert.textFields![1].text
                    let passwordAgainText = registerAlert.textFields![2].text
                    if let loginText = loginText, !loginText.isEmpty,
                       let passwordText = passwordText,
                       passwordText == passwordAgainText, !passwordText.isEmpty { finishRegisterAlertButton.isEnabled = true
                        registerAlert.message = ""
                    } else {
                        finishRegisterAlertButton.isEnabled = false
                    }
                }
            )
        }
    }
    
    @IBAction func showSignInAlert(_ sender: Any) {
        let signInAlert = UIAlertController(title: "Sign in", message: nil, preferredStyle: .alert)
        let enterButton = UIAlertAction(
            title: "Sign in",
            style: .default,
            handler: { _ in
                if self.login == signInAlert.textFields![0].text && self.password == signInAlert.textFields![1].text {
                    self.authorizationConditionLabel.text = "You are authorized"
                    self.showPushAlert(isTrue: true)
                } else {
                    self.authorizationConditionLabel.text = "Try again"
                    self.showPushAlert(isTrue: false)
                }
            }
        )
        
        enterButton.isEnabled = false
        signInAlert.addAction(enterButton)
        signInAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        signInAlert.addTextField { loginTextField in
            loginTextField.placeholder = "Login"
            verifySignIn(loginTextField)
        }
        
        signInAlert.addTextField { passwordTextField in
            passwordTextField.placeholder = "Password"
            passwordTextField.isSecureTextEntry = true
            verifySignIn(passwordTextField)
        }
        
        func verifySignIn(_ textField:UITextField) {
            NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: textField,
                queue: OperationQueue.main) { _ in
                    let loginText = signInAlert.textFields![0].text
                    let passwordText = signInAlert.textFields![1].text
                    if let loginText = loginText, !loginText.isEmpty, let passwordText = passwordText, !passwordText.isEmpty {
                        enterButton.isEnabled = true
                        signInAlert.message = ""
                    } else {
                        enterButton.isEnabled = false
                    }
                }
        }
        
        present(signInAlert, animated: true, completion: nil)
    }
    
    func showPushAlert(isTrue: Bool) {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        if isTrue == true {
            alert.title = "You are logged in "
        } else {
            alert.title = "Wrong password or login"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
