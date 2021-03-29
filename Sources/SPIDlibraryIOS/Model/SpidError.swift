//
// SPDX-FileCopyrightText: 2021 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import UIKit

/// This enum handles the various error cases
public enum SpidError: Error {
    // Returns this error if the request fails
    case UrlNotWorking(url:String)
    // Returns this error if the url is not in HTTPS
    case UrlNotHttps(key:String)
    // Returns this error if the controller isn't presented
    case NotPresent(className:String)
    // Returns this error if the key is invalid or empty
    case Settings(key:String)
    // Returns this error if the request times out
    case Timeout
    // Returns this error if the internet isn't available
    case NoInternet
    
    public var localizedDescription:String {
        switch self {
        
        case .UrlNotWorking(url: let url):
            return String.localizedStringWithFormat("error_url_not_working".localized(), url)
        case .NotPresent(className: let className):
            return String.localizedStringWithFormat("error_not_present".localized(), className)
        case .Settings(key: let key):
            return String.localizedStringWithFormat("error_key_settings".localized(), key)
        case .Timeout:
            return "error_timeout".localized()
        case .UrlNotHttps(key: let key):
            return String.localizedStringWithFormat("error_url_not_in_https".localized(), key)
        case .NoInternet:
            return String.localizedStringWithFormat("error_connection".localized())
        }
    }
}
