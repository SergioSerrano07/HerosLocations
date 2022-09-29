//
//  LoginViewController.swift
//  AppleMaps
//
//  Created by sergio serrano on 17/9/22.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Constants
    let viewModel = LoginViewModel()
    
    
    //MARK: - Cicle of life
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.loginButton.isEnabled = true
            }
            print(errorMessage)
        }
        
        viewModel.onLogin = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.loginButton.isEnabled = true
                
                let nextViewController = TableViewController()
                self?.navigationController?.setViewControllers([nextViewController], animated: true)
            }
        }
    }

    //MARK: - Actions
    
    @IBAction func onLoginTap(_ sender: Any) {
        activityIndicator.startAnimating()
        loginButton.isEnabled = false
        
        viewModel.login(with: userTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
        
            
            
            
//            if let token = token {
//                self.viewModel.saveToken(token: token)
//                DispatchQueue.main.async {
//                    self.activityIndicator.stopAnimating()
//                    self.view.isUserInteractionEnabled = true
//                    self.performSegue(withIdentifier: "goToMap", sender: nil)
//                }
//            }
        
}
