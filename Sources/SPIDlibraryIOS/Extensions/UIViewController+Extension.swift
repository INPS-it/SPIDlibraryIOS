// 
// SPDX-FileCopyrightText: 2024 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import Foundation
import UIKit

extension UIViewController {
    
    func presentViewController(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: .module)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        return vc
    }
}
