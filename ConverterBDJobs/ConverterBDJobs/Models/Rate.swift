//
//  Rate.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/16/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import Foundation

// MARK: - Rate
class Rate: Codable {
    let name, code, countryCode: String?
    let periods: [Period]
    
    enum CodingKeys: String, CodingKey {
        case name, code
        case countryCode = "country_code"
        case periods
    }
    
    init(name: String, code: String, countryCode: String, periods: [Period]) {
        self.name = name
        self.code = code
        self.countryCode = countryCode
        self.periods = periods
    }
}
