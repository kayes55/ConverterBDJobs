//
//  ViewController.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/13/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
            countryNameLbl.text = "Spain"
        }
    }
    @IBOutlet weak var originalAmount: UILabel!
    @IBOutlet weak var taxAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    var selectedIndex:IndexPath?
    
    var ratesCollection: [Double] = [Double]()
    var defaultRates: [Double] = [21.0,4.0,10.0]
    var defaultTexts: [String] = ["standard", "super_reduced", "reduced"]
    var rates: [Rate] = [Rate]()
    
    var saveManager = UserDefaults.standard
    
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
    
    
    func storeData(standard: Double? = 0.0, superReduced: Double? = 0.0, reduced: Double? = 0.0 ) {
        
        if !ratesCollection.isEmpty {
            ratesCollection.removeAll()
        }
        self.ratesCollection.append(standard ?? 0.0)
        self.ratesCollection.append(superReduced ?? 0.0)
        self.ratesCollection.append(reduced ?? 0.0)
    }
}

