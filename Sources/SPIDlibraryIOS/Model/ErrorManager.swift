//
// SPDX-FileCopyrightText: 2021 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import Foundation

struct ErrorManager {
    
    enum Error: String {
        case authPageUrl = "authPageUrl"
        case callbackPageUrl = "callbackPageUrl"
        case spidPageInfoUrl = "spidPageInfoUrl"
        case requestSpidPageUrl = "requestSpidPageUrl"
        case identityProviderKeys = "identityProviderKeys"
    }
    
    var spidConfig: SpidConfig?
    
    func checkError() -> SpidError? {
        guard let authPageUrl = spidConfig?.authPageUrl, !authPageUrl.isEmpty else {
            return SpidError.Settings(key: Error.authPageUrl.rawValue)
        }
    
        guard let callbackPageUrl = spidConfig?.callbackPageUrl, !callbackPageUrl.isEmpty else {
            return SpidError.Settings(key: Error.callbackPageUrl.rawValue)
        }
        
        guard let spidPageInfoUrl = spidConfig?.spidPageInfoUrl, !spidPageInfoUrl.isEmpty else {
            return SpidError.Settings(key: Error.spidPageInfoUrl.rawValue)
        }
        
        guard let requestSpidPageUrl = spidConfig?.requestSpidPageUrl, !requestSpidPageUrl.isEmpty else {
            return SpidError.Settings(key: Error.requestSpidPageUrl.rawValue)
        }

        guard let _ = spidConfig?.identityProviderKeys else {
            return SpidError.Settings(key: Error.identityProviderKeys.rawValue)
        }
        
        guard authPageUrl.checkHTTPS() else {
            return SpidError.UrlNotHttps(key: Error.authPageUrl.rawValue)
        }
        
        guard spidPageInfoUrl.checkHTTPS() else {
            return SpidError.UrlNotHttps(key: Error.spidPageInfoUrl.rawValue)
        }
        
        guard requestSpidPageUrl.checkHTTPS() else {
            return SpidError.UrlNotHttps(key: Error.requestSpidPageUrl.rawValue)
        }
        
        guard let _ = URL(string: authPageUrl)  else {
            return SpidError.UrlNotWorking(url: authPageUrl)
        }
        
        guard let _ = URL(string: spidPageInfoUrl) else {
            return SpidError.UrlNotWorking(url: spidPageInfoUrl)
        }
        
        guard let _ = URL(string: requestSpidPageUrl) else {
            return SpidError.UrlNotWorking(url: requestSpidPageUrl)
        }
        
        return nil
    }
}
