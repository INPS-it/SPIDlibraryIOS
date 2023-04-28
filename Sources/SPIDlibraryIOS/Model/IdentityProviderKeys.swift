//
// SPDX-FileCopyrightText: 2023 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import Foundation

// This object contains the keys that will be used to contact the service provider
public class IdentityProviderKeys {
    
    public var aruba: String
    public var etna: String
    public var infocamere: String
    public var infocert: String
    public var lepida: String
    public var namirial: String
    public var poste: String
    public var sielte: String
    public var spiditalia: String
    public var teamsystem: String
    public var tim: String
    
    public init(aruba: String, etna: String, infocamere: String, infocert: String, lepida: String, namirial: String, poste: String, sielte: String, spiditalia: String, teamsystem: String, tim: String) {
        self.aruba = aruba
        self.etna = etna
        self.infocamere = infocamere
        self.infocert = infocert
        self.lepida = lepida
        self.namirial = namirial
        self.poste = poste
        self.sielte = sielte
        self.spiditalia = spiditalia
        self.teamsystem = teamsystem
        self.tim = tim
    }
    
}

