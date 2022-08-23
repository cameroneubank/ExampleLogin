//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Cameron Eubank on 8/23/22.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didPressLogoutButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let authentication: Authentication
    
    init(authentication: Authentication) {
        self.authentication = authentication
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profile"
        [label, logoutButton].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            logoutButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -16.0)
        ])
    }
    
    // MARK: - Target Action
    
    @objc private func didPressLogoutButton(_ sender: Any) {
        authentication.logout()
    }
}
