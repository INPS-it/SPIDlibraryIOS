//
// SPDX-FileCopyrightText: 2021 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import Foundation

// This object contains the keys that will be used to contact the service provider
public class IdentityProviderKeys {
    
    public var aruba: String
    public var infocert: String
    public var intesa: String
    public var lepida: String
    public var namirial: String
    public var poste: String
    public var sielte: String
    public var spiditalia: String
    public var teamSystem: String
    public var tim: String
    
    public init(aruba: String, infocert: String, intesa: String, lepida: String, namirial: String, poste: String, sielte: String, spiditalia: String, teamSystem: String, tim: String) {
        self.aruba = aruba
        self.infocert = infocert
        self.intesa = intesa
        self.lepida = lepida
        self.namirial = namirial
        self.poste = poste
        self.sielte = sielte
        self.spiditalia = spiditalia
        self.teamSystem = teamSystem
        self.tim = tim
    }
    
}

