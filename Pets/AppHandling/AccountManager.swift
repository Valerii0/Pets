//
//  AccountManager.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/13/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

final class AccountManager {
    static func setLoginId(id: String) {
        UserDefaults.standard.set(id, forKey: UserDefaultsValues.loginId.rawValue)
    }
    
    static func getLoginId() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsValues.loginId.rawValue)
    }
    
    static func removeLoginId() {
        UserDefaults.standard.set(nil, forKey: UserDefaultsValues.loginId.rawValue)
    }
    
    static func setSide(side: String) {
        UserDefaults.standard.set(side, forKey: UserDefaultsValues.side.rawValue)
    }
    
    static func getSide() -> Side? {
        if let sideString = UserDefaults.standard.string(forKey: UserDefaultsValues.side.rawValue),
            let side = Side(rawValue: sideString) {
            return side
        }
        return nil
    }
    
    static func removeSide() {
        UserDefaults.standard.set(nil, forKey: UserDefaultsValues.side.rawValue)
    }
    
    static func stateToStart() -> State {
        if getLoginId() == nil {
            return .login
        } else if getSide() == nil {
            return .side
        } else {
            return .app
        }
    }
    
    static func ApiUrl() -> String {
        if let side = getSide() {
            switch side {
            case .cat:
                return Api.catUrl.rawValue
            case .dog:
                return Api.dogUrl.rawValue
            }
        }
        return Api.catUrl.rawValue
    }
    
    static func ApiKey() -> String {
        if let side = getSide() {
            switch side {
            case .cat:
                return Api.catKey.rawValue
            case .dog:
                return Api.dogKey.rawValue
            }
        }
        return Api.catKey.rawValue
    }
    
    static func UserId() -> String {
        if let loginId = getLoginId() {
            return loginId
        }
        return "default"
    }
}
