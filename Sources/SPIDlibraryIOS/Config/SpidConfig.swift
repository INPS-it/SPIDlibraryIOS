// 
// SPDX-FileCopyrightText: 2024 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import Foundation
import UIKit

public class SpidConfig {

    // Url service provider page login
    public var authPageUrl: String?
    // Redirect URL called by the identity provider after logging in
    public var callbackPageUrl: String?
    // URL Information page about SPID
    public var spidPageInfoUrl: String?
    // URL page to request SPID
    public var requestSpidPageUrl: String?
    // Request timeout login
    public var timeout: Int = 30
    // Additional query string params
    public var queryStringParams: String? = nil
    // This model contains the identity providers keys
    public var identityProviderKeys: IdentityProviderKeys?
    
    public init() {}
    
    public convenience init(authPageUrl: String, callbackPageUrl: String, spidPageInfoUrl: String, requestSpidPageUrl: String, identityProviderKeys: IdentityProviderKeys?, timeout: Int = 30, queryStringParams: String? = nil){
        self.init()
        self.authPageUrl = authPageUrl
        self.callbackPageUrl = callbackPageUrl
        self.spidPageInfoUrl = spidPageInfoUrl
        self.requestSpidPageUrl = requestSpidPageUrl
        self.identityProviderKeys = identityProviderKeys
        self.timeout = UIAccessibility.isVoiceOverRunning ? Int.max : timeout
        self.queryStringParams = queryStringParams
    }
}

