//
//  Period.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/16/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import Foundation

// MARK: - Period
class Period: Codable {
    let effectiveFrom: String?
    let rates: Rates
    
    enum CodingKeys: String, CodingKey {
        case effectiveFrom = "effective_from"
        case rates
    }
    
    init(effectiveFrom: String, rates: Rates) {
        self.effectiveFrom = effectiveFrom
        self.rates = rates
    }
}
