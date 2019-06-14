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

// MARK: - Rates
class Rates: Codable {
    let superReduced, reduced: Double?
    let standard: Double
    let reduced1, reduced2, parking: Double?
    
    enum CodingKeys: String, CodingKey {
        case superReduced = "super_reduced"
        case reduced, standard, reduced1, reduced2, parking
    }
    
    init(superReduced: Double?, reduced: Double?, standard: Double, reduced1: Double?, reduced2: Double?, parking: Double?) {
        self.superReduced = superReduced
        self.reduced = reduced
        self.standard = standard
        self.reduced1 = reduced1
        self.reduced2 = reduced2
        self.parking = parking
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
