// 
// SPDX-FileCopyrightText: 2024 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import Foundation

extension NSObject {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
