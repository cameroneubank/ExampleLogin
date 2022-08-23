//
//  Authentication.swift
//  Navigation
//
//  Created by Cameron Eubank on 8/23/22.
//

import Combine
import Foundation

enum AuthenticationStatus: String {
    case authenticated
    case unauthenticated
}

final class Authentication {
    
    let authenticationStatusSubject: CurrentValueSubject<AuthenticationStatus, Never>
    
    private var authenticationStatus: AuthenticationStatus {
        didSet {
            authenticationStatusSubject.send(authenticationStatus)
            // Obviously we wouldn't do this in UserDefaults, this is just an example.
            UserDefaults.standard.set(authenticationStatus.rawValue, forKey: "authenticationStatus")
        }
    }
    
    init() {
        self.authenticationStatus = {
            if let persistedValue = UserDefaults.standard.string(forKey: "authenticationStatus") {
                return AuthenticationStatus(rawValue: persistedValue) ?? .unauthenticated
            } else {
                UserDefaults.standard.set(AuthenticationStatus.unauthenticated.rawValue,
                                          forKey: "authenticationStatus")
                return .unauthenticated
            }
        }()
        self.authenticationStatusSubject = CurrentValueSubject(authenticationStatus)
    }
    
    func logout() {
        authenticationStatus = .unauthenticated
    }
    
    func login() {
        authenticationStatus = .authenticated
    }
}
