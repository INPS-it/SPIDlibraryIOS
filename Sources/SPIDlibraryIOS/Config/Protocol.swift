// 
// SPDX-FileCopyrightText: 2021 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import UIKit

//Implement this protocol in the class where you want to instantiate the login with spid

public protocol SpidDelegate: AnyObject {
    func loginSuccess(response: SpidResponse)
    func onError(error: SpidError)
}
