//
// SPDX-FileCopyrightText: 2023 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import Foundation

struct ErrorManager {
    
    enum Error: String {
        case authPageUrl
        case callbackPageUrl
        case spidPageInfoUrl
        case requestSpidPageUrl
        case identityProviderKeys
    }
    
    var spidConfig: SpidConfig?
    
    private func tryError(case: Error, value: Any?) throws {
        if let value = value as? String, value.isEmpty == false {
            switch `case` {
            case .authPageUrl, .spidPageInfoUrl, .requestSpidPageUrl:
                guard value.checkHTTPS() else {
                    throw SpidError.UrlNotHttps(key: `case`.rawValue)
                }
                
                guard let _ = URL(string: value) else {
                    throw SpidError.UrlNotWorking(url: value)
                }
            default: break
            }
            
        } else if let _ = value as? IdentityProviderKeys {
            return
        } else {
            throw SpidError.Settings(key: `case`.rawValue)
        }
    }
    
    func checkError() -> SpidError? {
        do {
            try tryError(case: .authPageUrl, value: spidConfig?.authPageUrl)
            try tryError(case: .callbackPageUrl, value: spidConfig?.callbackPageUrl)
            try tryError(case: .spidPageInfoUrl, value: spidConfig?.spidPageInfoUrl)
            try tryError(case: .requestSpidPageUrl, value: spidConfig?.requestSpidPageUrl)
            try tryError(case: .identityProviderKeys, value: spidConfig?.identityProviderKeys)
        } catch {
            if let error = error as? SpidError {
                return error
            }
        }
        
        return nil
    }
}
