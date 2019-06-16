//
//  Rates.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/16/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import Foundation

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
