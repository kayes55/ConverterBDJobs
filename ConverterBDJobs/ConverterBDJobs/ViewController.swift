//
//  ViewController.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/13/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SendCountryNameDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var currencyInputField: IKPlaceholder! {
        didSet {
            currencyInputField.delegate = self
        }
    }
    

    @IBOutlet weak var dropDownMenu: WrapperView!
    @IBOutlet weak var countryNameLbl: UILabel! {
        didSet {
            countryNameLbl.textColor = UIColor.black
        }
    }
    @IBOutlet weak var originalAmount: UILabel!
    @IBOutlet weak var taxAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    var isButtonClicked: Bool = false
    var isCountrySelected: Bool = false
    
    var radioButtonGroup: IKRadioButtonGroup!
    
    var rates: [Rate] = [Rate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShowProgress.shared.showProgressHUD()
        
        APIClient.shared.getWatchlist { (rates, error) in
            self.rates = rates
            
            DispatchQueue.main.async {
                self.setUpDropdownData()
            }
        }
        
        
//        radioButtonGroup = IKRadioButtonGroup()
//        radioButtonGroup.delegate = self
//        radioButtonGroup.appendToRadioGroup(radioButtons: [standardBtn,superBtn, reduceBtn])
        
        WrapperView.delegate = self
        
        ShowProgress.shared.dismissProgressHUD()
    }
    
    
    func setUpDropdownData() {
        dropDownMenu.optionArray = self.rates
    }
    
    func showCountryName(name: String, selectedIndex: Int) {
        print("Selected Country is: \(name)")
        self.isCountrySelected = true
        print("Selected Country's Standerd index is: \(self.rates[selectedIndex].periods[0].rates.standard)")
        var periods = self.rates[selectedIndex].periods
        for i in 0..<periods.count {
            print("standerd (\(periods[i].rates.standard)%)")
            print("super_reduced (\(periods[i].rates.superReduced)%)")
            print("reduced (\(periods[i].rates.reduced)%)")
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("End Editing")
        self.originalAmount.text = textField.text
    }

    
}

