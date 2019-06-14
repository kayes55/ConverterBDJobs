//
//  TaxCalculator.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/14/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import Foundation

class TaxCalculator {
    static let shared = TaxCalculator()
    
    private init() {
        
    }
    
    
    func tax(originalAmount: String, rate: Int) -> String {
        guard let temp = Double(originalAmount) else {return ""}
        
        switch rate {
        case 1:
            return String((temp/100.00)*21)
        case 2:
            return String((temp/100.00)*4)
        case 3:
            return String((temp/100.00)*10)
        default:
            return ""
        }
    }
    
    func calculateTotal(originalAmount: String?, taxAmount: String?) -> String? {
        if let org = originalAmount, let tax = taxAmount {
            return String(Double(org)! + Double(tax)!)
        } else {
            return ""
        }
    }
}
