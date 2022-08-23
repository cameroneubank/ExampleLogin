//
//  TabBarController.swift
//  Navigation
//
//  Created by Cameron Eubank on 8/23/22.
//

import Combine
import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - View Controllers
    
    private lazy var mhpViewController: UIViewController = {
        let viewController = MHPViewController().embeddedInNavigationController()
        viewController.tabBarItem = {
            UITabBarItem(title: "Home",
                         image: UIImage(systemName: "xmark"),
                         selectedImage: nil)
        }()
        return viewController
    }()
    
    private lazy var searchViewController: UIViewController = {
        let viewController = SearchViewController().embeddedInNavigationController()
        viewController.tabBarItem = {
            UITabBarItem(title: "Search",
                         image: UIImage(systemName: "xmark"),
                         selectedImage: nil)
        }()
        return viewController
    }()
    
    private lazy var messagesViewController: UIViewController = {
        let viewController = MessagesViewController().embeddedInNavigationController()
        viewController.tabBarItem = {
            UITabBarItem(title: "Messages",
                         image: UIImage(systemName: "xmark"),
                         selectedImage: nil)
        }()
        return viewController
    }()
    
    private lazy var jobsViewController: UIViewController = {
        let viewController = JobsViewController().embeddedInNavigationController()
        viewController.tabBarItem = {
            UITabBarItem(title: "Jobs",
                         image: UIImage(systemName: "xmark"),
                         selectedImage: nil)
        }()
        return viewController
    }()
    
    private lazy var profileViewController: UIViewController = {
        let viewController = ProfileViewController(authentication: authentication).embeddedInNavigationController()
        viewController.tabBarItem = {
            UITabBarItem(title: "Profile",
                         image: UIImage(systemName: "xmark"),
                         selectedImage: nil)
        }()
        return viewController
    }()
    
    // MARK: - Initialization
    
    private let authentication: Authentication
    private var cancellables = Set<AnyCancellable>()
    
    init(authentication: Authentication) {
        self.authentication = authentication
        super.init(nibName: nil, bundle: nil)
        viewControllers = [
            mhpViewController,
            searchViewController,
            messagesViewController,
            jobsViewController,
            profileViewController
        ]
        handleSubscribers()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func handleSubscribers() {
        authentication.authenticationStatusSubject.sink { _ in
            return
        } receiveValue: { [weak self] authenticationStatus in
            switch authenticationStatus {
            case .authenticated:
                return // Don't care.
            case .unauthenticated:
                guard let self = self, let window = self.view.window else { return }
                window.rootViewController = LoginViewController(authentication: self.authentication)
                UIView.transition(with: window,
                                  duration: 0.2,
                                  options: .transitionCrossDissolve,
                                  animations: nil,
                                  completion: nil)
            }
        }.store(in: &cancellables)
    }
}
