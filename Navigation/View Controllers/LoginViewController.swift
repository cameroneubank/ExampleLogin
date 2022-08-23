//
//  LoginViewController.swift
//  Navigation
//
//  Created by Cameron Eubank on 8/23/22.
//

import Foundation
import SwiftUI

final class LoginViewController: UIViewController {
    
    private lazy var hostingController: UIHostingController<LoginView> = {
        let viewModel = LoginViewModel(authentication: authentication, delegate: self)
        return UIHostingController(rootView: LoginView(viewModel: viewModel))
    }()
    
    private let authentication: Authentication
    
    init(authentication: Authentication) {
        self.authentication = authentication
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        hostingController.didMove(toParent: self)
        [hostingController.view].forEach { view.addSubview($0) }
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func viewModelDidSelectLogin(_ viewModel: LoginViewModel) {
        guard let window = view.window else { return }
        window.rootViewController = TabBarController(authentication: authentication)
        UIView.transition(with: window,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}

protocol LoginViewModelDelegate: AnyObject {
    func viewModelDidSelectLogin(_ viewModel: LoginViewModel)
}

class LoginViewModel {
    
    private let authentication: Authentication
    private weak var delegate: LoginViewModelDelegate?
    
    init(authentication: Authentication, delegate: LoginViewModelDelegate) {
        self.authentication = authentication
        self.delegate = delegate
    }
    
    func selectLogin() {
        authentication.login()
        delegate?.viewModelDidSelectLogin(self)
    }
}

private struct LoginView: View {
    let viewModel: LoginViewModel
    
    var body: some View {
        Button {
            viewModel.selectLogin()
        } label: {
            Text("Login")
        }
    }
}
