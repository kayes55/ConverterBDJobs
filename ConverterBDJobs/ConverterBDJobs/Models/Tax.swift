//
//  Tax.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/14/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import Foundation

// MARK: - Tax
class Tax: Codable {
    let details: String
    let version: JSONNull?
    let rates: [Rate]
    
    init(details: String, version: JSONNull?, rates: [Rate]) {
        self.details = details
        self.version = version
        self.rates = rates
    }
}
