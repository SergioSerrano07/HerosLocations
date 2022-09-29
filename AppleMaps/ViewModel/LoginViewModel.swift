//
//  LoginViewModel.swift
//  AppleMaps
//
//  Created by sergio serrano on 17/9/22.
//

import Foundation
import KeychainSwift

final class LoginViewModel {
    
    //MARK: - Constants
    private var networkModel: NetworkModel
    private var keyChain: KeychainSwift
    
    var onError: ((String) -> Void)?
    var onLogin: (() -> Void)?
    
    init(networkModel: NetworkModel = NetworkModel(),
         keyChain: KeychainSwift = KeychainSwift(),
         onError: ((String) -> Void)? = nil,
         onLogin: (() -> Void)? = nil) {
        
        self.keyChain = keyChain
        self.networkModel = networkModel
        self.onLogin = onLogin
        self.onError = onError
        
    }
    //MARK: - call service
    func login(with user: String, password: String) {
        networkModel.login(user: user, password: password) { [weak self] token, error in
            if let error = error {
                self?.onError?(error.localizedDescription)
            }
            
            guard let token = token, !token.isEmpty else {
                self?.onError?("Wrong token")
                return
            }
            
            self?.keyChain.set(token, forKey: "KCToken")
            self?.onLogin?()
            
        }
    }
    
}
