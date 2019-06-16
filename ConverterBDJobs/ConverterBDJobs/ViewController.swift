//
//  ViewController.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/13/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SendCountryNameDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var radioBtnTableView: UITableView!
    @IBOutlet weak var currencyInputField: UITextField! {
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
    
    var selectedIndex:IndexPath?
    
    var ratesCollection: [Double] = [Double]()
    
    var rates: [Rate] = [Rate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ShowProgress.shared.showProgressHUD()
        
        APIClient.shared.getWatchlist { (rates, error) in
            self.rates = rates
            
            DispatchQueue.main.async {
                self.setUpDropdownData()
                self.view.bringSubviewToFront(self.dropDownMenu)
            }
        }
        
        WrapperView.delegate = self
        radioBtnTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "Cell")
        ShowProgress.shared.dismissProgressHUD()
    }
    
    
    func setUpDropdownData() {
        dropDownMenu.optionArray = self.rates
    }
    
    func showCountryName(name: String, selectedIndex: Int) {
        print("Selected Country is: \(name)")
        self.isCountrySelected = true
//        print("Selected Country's Standerd index is: \(self.rates[selectedIndex].periods[0].rates.standard)")
//        print("Selected Country's superReduced index is: \(self.rates[selectedIndex].periods[0].rates.superReduced)")
//        print("Selected Country's reduced index is: \(self.rates[selectedIndex].periods[0].rates.reduced)")
        var periods = self.rates[selectedIndex].periods
        
        self.amalgam(standard: periods[0].rates.standard, superReduced: periods[0].rates.superReduced, reduced: periods[0].rates.reduced)
        self.selectedIndex = nil
        DispatchQueue.main.async {
            self.radioBtnTableView.reloadData()
        }
        
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("End Editing")
        self.originalAmount.text = textField.text
    }
    
    
    //MARK:- delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ratesCollection.isEmpty {
            return 1
        } else {
            return ratesCollection.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        
        cell.selectionStyle = .none
        
        if self.ratesCollection.isEmpty {
            cell.taxrateLabel.text = "Default 10.0%"
            if (selectedIndex == indexPath) {
                cell.radioBtnIcon.image = UIImage(named: "checked")
            } else {
                cell.radioBtnIcon.image = UIImage(named: "unchecked")
            }
        } else {
            cell.taxrateLabel.text = "\(self.ratesCollection[indexPath.row])%"
            if (selectedIndex == indexPath) {
                cell.radioBtnIcon.image = UIImage(named: "checked")
            } else {
                cell.radioBtnIcon.image = UIImage(named: "unchecked")
            }
        }
        
        
        
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        tableView.reloadData()
        
        self.taxAmount.text = "\(TaxCalculator.shared.tax(originalAmount: self.originalAmount.text!, rate: self.ratesCollection[indexPath.row]))"
        self.totalAmount.text = TaxCalculator.shared.calculateTotal(originalAmount: self.originalAmount.text, taxAmount: self.taxAmount.text)
    }
    
    func amalgam(standard: Double? = 0.0, superReduced: Double? = 0.0, reduced: Double? = 0.0 ) {
        
        if !ratesCollection.isEmpty {
            ratesCollection.removeAll()
        }
        self.ratesCollection.append(standard ?? 0.0)
        self.ratesCollection.append(superReduced ?? 0.0)
        self.ratesCollection.append(reduced ?? 0.0)
    }
}

