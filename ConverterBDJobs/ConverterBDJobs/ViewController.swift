//
//  ViewController.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/13/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RadioButtonGroupDelegate, SendCountryNameDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var currencyInputField: IKPlaceholder! {
        didSet {
            currencyInputField.delegate = self
        }
    }
    
    @IBOutlet weak var standardBtn: IKRadioButton!
    @IBOutlet weak var superBtn: IKRadioButton!
    @IBOutlet weak var reduceBtn: IKRadioButton!
    @IBOutlet weak var dropDownMenu: WrapperView!
    @IBOutlet weak var originalAmount: UILabel!
    @IBOutlet weak var taxAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    var isButtonClicked: Bool = false
    var isCountrySelected: Bool = false
    
    var radioButtonGroup: IKRadioButtonGroup!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = APIClient.getWatchlist(completion: { (period, err) in
            for i in 0..<period.count {
                print(period[i].name!)
                print(period[i].code!)
                print(period[i].countryCode!)
                for j in 0..<period[i].periods.count {
                    print(period[i].periods[j].rates.standard)
                }
            }
        })
        
//        jsonParse()
        setUpDummyData()
        radioButtonGroup = IKRadioButtonGroup()
        radioButtonGroup.delegate = self
        radioButtonGroup.appendToRadioGroup(radioButtons: [standardBtn,superBtn, reduceBtn])
        
        WrapperView.delegate = self
        
        switch UserDefaults.standard.integer(forKey: "ButtonTag") {
        case 1:
            standardBtn.isRadioSelected = true
            taxAmount.text = "21.0"
        case 2:
            superBtn.isRadioSelected = true
            taxAmount.text = "4.0"
        case 3:
            reduceBtn.isRadioSelected = true
            taxAmount.text = "10.0"
        default:
            print("Not Found")
        }
                
    }
    
    func radioButtonClicked(button: IKRadioButton) {
        print(button.tag)
    
        let temp = UserDefaults.standard.integer(forKey: "ButtonTag")
        if (temp == 1 || temp == 2 || temp == 3) {
            UserDefaults.standard.removeObject(forKey: "ButtonTag")
        }
        UserDefaults.standard.set(button.tag, forKey: "ButtonTag")
        
        switch button.tag {
        case 1:
            taxAmount.text = TaxCalculator.shared.tax(originalAmount: self.originalAmount.text!, rate: 1)
            totalAmount.text = TaxCalculator.shared.calculateTotal(originalAmount: self.originalAmount.text, taxAmount: taxAmount.text)
        case 2:
            taxAmount.text = TaxCalculator.shared.tax(originalAmount: self.originalAmount.text!, rate: 2)
            totalAmount.text = TaxCalculator.shared.calculateTotal(originalAmount: self.originalAmount.text, taxAmount: taxAmount.text)
        case 3:
            taxAmount.text = TaxCalculator.shared.tax(originalAmount: self.originalAmount.text!, rate: 3)
            totalAmount.text = TaxCalculator.shared.calculateTotal(originalAmount: self.originalAmount.text, taxAmount: taxAmount.text)
        default:
            print("Garbage")
        }
        
    }
    
    func setUpDummyData() {
        let option =  Options()
        dropDownMenu.optionArray = option.countries
//        dropDownMenu.optionIds = option.ids
    }
    
    func showCountryName(name: String) {
        print("Selected Country is: \(name)")
        self.isCountrySelected = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("End Editing")
        self.originalAmount.text = textField.text
    }
    
    func jsonParse() {
        let url = "https://jsonvat.com/"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            
            if let d = data {
                if let value = String(data: d, encoding: String.Encoding.ascii) {
                    
                    if let jsonData = value.data(using: String.Encoding.utf8) {
                        do {
                            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                            
                            if let arr = json["rows"] as? [[String: Any]] {
                                debugPrint(arr)
                            }
                            
                            print(json)
                            
                        } catch {
                            NSLog("ERROR \(error.localizedDescription)")
                        }
                    }
                }
                
            }
            }.resume()
    }

    
}

