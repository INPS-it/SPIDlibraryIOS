// 
// SPDX-FileCopyrightText: 2024 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, bundle: .main, comment: "")
    }
    
}
