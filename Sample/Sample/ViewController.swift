// 
// SPDX-FileCopyrightText: 2024 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import UIKit
import SPIDlibraryIOS


class ViewController: UIViewController, SpidDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func tapLoginWithSpid(_ sender: Any) {
        
        let identityProviderKeys = IdentityProviderKeys.init(aruba: Constants.IdentityProvider.aruba,
                                                             etna: Constants.IdentityProvider.etna,
                                                             infocamere: Constants.IdentityProvider.infocamere,
                                                             infocert: Constants.IdentityProvider.infocert,
                                                             intesi: Constants.IdentityProvider.intesi,
                                                             lepida: Constants.IdentityProvider.lepida,
                                                             namirial: Constants.IdentityProvider.namirial,
                                                             poste: Constants.IdentityProvider.poste,
                                                             sielte: Constants.IdentityProvider.sielte,
                                                             spiditalia: Constants.IdentityProvider.spiditalia,
                                                             teamsystem: Constants.IdentityProvider.teamsystem,
                                                             tim: Constants.IdentityProvider.tim)
        
        let spidConfig = SpidConfig.init(authPageUrl: Constants.authPageUrl, callbackPageUrl: Constants.callbackPageUrl, spidPageInfoUrl: Constants.spidPageInfoUrl, requestSpidPageUrl: Constants.requestSpidPageUrl, identityProviderKeys: identityProviderKeys, queryStringParams: Constants.queryStringParams)
        
        SpidViewController.present(delegate: self, spidConfig: spidConfig)
    }
    
    func loginSuccess(response: SpidResponse) {
        print("Login success")
        showAlert(title: "title".localized(), message: "login_success".localized())
    }
    
    func onError(error: SpidError) {
        print("Login error")
        showAlert(title: "title".localized(), message: error.localizedDescription)
    }
}

