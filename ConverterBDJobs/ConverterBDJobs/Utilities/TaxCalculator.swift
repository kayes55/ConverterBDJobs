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
        return String((temp/100.00)*Double(rate))
        
    }
    
    func calculateTotal(originalAmount: String?, taxAmount: String?) -> String? {
        if let org = originalAmount, let tax = taxAmount {
            return String(Double(org)! + Double(tax)!)
        } else {
            return ""
        }
    }
}
