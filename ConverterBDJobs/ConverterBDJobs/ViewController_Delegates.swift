//
//  ViewController_Delegates.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/16/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import UIKit

extension ViewController: SendCountryNameDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- tableView delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ratesCollection.isEmpty {
            return defaultRates.count
        } else {
            return ratesCollection.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        
        cell.selectionStyle = .none
        
        if self.ratesCollection.isEmpty {
            cell.taxrateLabel.text = "\(self.defaultTexts[indexPath.row]) \(self.defaultRates[indexPath.row])%"
            if (selectedIndex == indexPath) {
                cell.radioBtnIcon.image = UIImage(named: "checked")
            } else {
                cell.radioBtnIcon.image = UIImage(named: "unchecked")
            }
        } else {
            cell.taxrateLabel.text = "\(self.defaultTexts[indexPath.row]) \(self.ratesCollection[indexPath.row])%"
            if (selectedIndex == indexPath) {
                cell.radioBtnIcon.image = UIImage(named: "checked")
            } else {
                cell.radioBtnIcon.image = UIImage(named: "unchecked")
            }
        }
        
        
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if currencyInputField.text!.isEmpty {
            AlertManager.shared.showAlert(title: "Warning!", message: "Currency Field cannot be empty", vc: self)
        } else {
            selectedIndex = indexPath
            tableView.reloadData()
            
            if self.ratesCollection.isEmpty {
                self.taxAmount.text = "\(TaxCalculator.shared.tax(originalAmount: self.originalAmount.text!, rate: self.defaultRates[indexPath.row]))"
                self.totalAmount.text = TaxCalculator.shared.calculateTotal(originalAmount: self.originalAmount.text, taxAmount: self.taxAmount.text)
            } else {
                self.taxAmount.text = "\(TaxCalculator.shared.tax(originalAmount: self.originalAmount.text!, rate: self.ratesCollection[indexPath.row]))"
                self.totalAmount.text = TaxCalculator.shared.calculateTotal(originalAmount: self.originalAmount.text, taxAmount: self.taxAmount.text)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sectionName: String = "Vat Rates:"
        return sectionName
    }
    
    //MARK:- textField Delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.originalAmount.text = textField.text
    }
    
    
    //MARK:- SendCountryNameDelegate method
    func showCountryName(name: String, selectedIndex: Int) {
        var periods = self.rates[selectedIndex].periods
        
        self.storeData(standard: periods[0].rates.standard, superReduced: periods[0].rates.superReduced, reduced: periods[0].rates.reduced)
        self.selectedIndex = nil
        DispatchQueue.main.async {
            self.radioBtnTableView.reloadData()
        }
    }
}
