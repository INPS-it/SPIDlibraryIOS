// SPDX-FileCopyrightText: 2023 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import XCTest
import Foundation

@testable import SPIDlibraryIOS

final class SPIDlibraryIOSTests: XCTestCase {
    
    let identityProviderKeys = IdentityProviderKeys(aruba: "aruba", infocert: "infocert", intesa: "intesa", lepida: "lepida", namirial: "namirial", poste: "poste", sielte: "sielte", spiditalia: "spiditalia", teamsystem: "teamsystem", tim: "tim")
    
    func testPresentProviderUI() {
        let instance = SpidViewController.instance()
        XCTAssertNotNil(instance, "Errore nel presentare l'istanza della classe \(SpidViewController.identifier)")
    }
    
    func testPresentLoginUI() {
        let instance = LoginViewController.instance()
        XCTAssertNotNil(instance, "Errore nel presentare l'istanza della classe \(LoginViewController.identifier)")
    }
    
    func testEmptyAuthPageUrl(){
        let spidConfig = SpidConfig.init(authPageUrl: "", callbackPageUrl: "", spidPageInfoUrl: "", requestSpidPageUrl: "", identityProviderKeys: nil, queryStringParams: "")
        let error = ErrorManager.init(spidConfig: spidConfig).checkError()
        XCTAssertNil(error, error?.localizedDescription ?? "")
    }
    
    func testEmptyCallbackPageUrl(){
        let spidConfig = SpidConfig.init(authPageUrl: "https://TEST",
                                             callbackPageUrl: "",
                                             spidPageInfoUrl: "",
                                             requestSpidPageUrl: "",
                                             identityProviderKeys: identityProviderKeys,
                                             queryStringParams: "")
        let error = ErrorManager.init(spidConfig: spidConfig).checkError()
        XCTAssertNil(error, error?.localizedDescription ?? "")
    }
    
    func testEmptySpidPageInfoUrl(){
        let spidConfig = SpidConfig.init(authPageUrl: "https://TEST",
                                             callbackPageUrl: "https://TEST",
                                             spidPageInfoUrl: "",
                                             requestSpidPageUrl: "",
                                             identityProviderKeys: identityProviderKeys,
                                             queryStringParams: "")
        let error = ErrorManager.init(spidConfig: spidConfig).checkError()
        XCTAssertNil(error, error?.localizedDescription ?? "")
    }
    
    func testEmptyRequestSpidPageUrl(){
        let spidConfig = SpidConfig.init(authPageUrl: "https://TEST",
                                             callbackPageUrl: "https://TEST",
                                             spidPageInfoUrl: "https://TEST",
                                             requestSpidPageUrl: "",
                                             identityProviderKeys: identityProviderKeys,
                                             queryStringParams: "")
        let error = ErrorManager.init(spidConfig: spidConfig).checkError()
        XCTAssertNil(error, error?.localizedDescription ?? "")
    }
    
    func testHttpsPageAuthUrl(){
        let spidConfig = SpidConfig.init(authPageUrl: "http://TEST",
                                             callbackPageUrl: "https://TEST",
                                             spidPageInfoUrl: "https://TEST",
                                             requestSpidPageUrl: "https://TEST",
                                             identityProviderKeys: identityProviderKeys,
                                             queryStringParams: "")
        let error = ErrorManager.init(spidConfig: spidConfig).checkError()
        XCTAssertNil(error, error?.localizedDescription ?? "")
    }
    
    func testHttpsSpidPageInfoUrl(){
        let spidConfig = SpidConfig.init(authPageUrl: "https://TEST",
                                             callbackPageUrl: "https://TEST",
                                             spidPageInfoUrl: "http://TEST",
                                             requestSpidPageUrl: "https://TEST",
                                             identityProviderKeys: identityProviderKeys,
                                             queryStringParams: "")
        let error = ErrorManager.init(spidConfig: spidConfig).checkError()
        XCTAssertNil(error, error?.localizedDescription ?? "")
    }
    
    func testHttpsRequestSpidPageUrl(){
        let spidConfig = SpidConfig.init(authPageUrl: "https://TEST",
                                             callbackPageUrl: "https://TEST",
                                             spidPageInfoUrl: "https://TEST",
                                             requestSpidPageUrl: "http://TEST",
                                             identityProviderKeys: identityProviderKeys,
                                             queryStringParams: "")
        let error = ErrorManager.init(spidConfig: spidConfig).checkError()
        XCTAssertNil(error, error?.localizedDescription ?? "")
    }
    
    func testSpidConfigSuccess(){
        let spidConfig = SpidConfig.init(authPageUrl: "https://TEST",
                                             callbackPageUrl: "https://TEST",
                                             spidPageInfoUrl: "https://TEST",
                                             requestSpidPageUrl: "https://TEST",
                                             identityProviderKeys: identityProviderKeys,
                                             queryStringParams: "")
        let error = ErrorManager.init(spidConfig: spidConfig).checkError()
        XCTAssertNil(error, error?.localizedDescription ?? "")
    }
    
    static var allTests = [
        ("testPresentProviderUI", testPresentProviderUI),
        ("testPresentLoginUI", testPresentLoginUI),
    ]
}
