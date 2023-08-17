//
//  MovieLoginViewController.swift
//  TheMovieDBChallenge
//
//  Created by Kevin Candia Villagómez on 7/03/23.
//

import UIKit

protocol MovieLoginViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MovieLoginPresenterProtocol? { get set }
    
    func callBackWithNotSuccess()
}

class MovieLoginViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: MovieLoginPresenterProtocol?
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        userTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
    }
    
    @objc func loginButtonPressed(_ button: UIButton) {
        if userTextField.text != "" && passwordTextField.text != "" {
            guard let user = userTextField.text, let password = passwordTextField.text else {
                 return
            }
            presenter?.callLogin(user, password)
        } else {
            showAlert("Ups", "El usuario o la clave estan vacios")
        }
    }

}

extension MovieLoginViewController: MovieLoginViewProtocol {
    func callBackWithNotSuccess() {
        showAlert("Error", "El usuario o clave son incorrectos")
    }
    
    
}
