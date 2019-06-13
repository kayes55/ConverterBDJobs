//
//  ViewController.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/13/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RadioButtonGroupDelegate, SendCountryNameDelegate {
    
    
    @IBOutlet weak var standardBtn: IKRadioButton!
    @IBOutlet weak var superBtn: IKRadioButton!
    @IBOutlet weak var reduceBtn: IKRadioButton!
    @IBOutlet weak var dropDownMenu: WrapperView!
    
    var isButtonClicked: Bool = false
    
    var radioButtonGroup: IKRadioButtonGroup!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDummyData()
        radioButtonGroup = IKRadioButtonGroup()
        radioButtonGroup.delegate = self
        radioButtonGroup.appendToRadioGroup(radioButtons: [standardBtn,superBtn, reduceBtn])
        
        WrapperView.delegate = self
        
        switch UserDefaults.standard.integer(forKey: "ButtonTag") {
        case 1:
            standardBtn.isRadioSelected = true
        case 2:
            superBtn.isRadioSelected = true
        case 3:
            reduceBtn.isRadioSelected = true
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
        
    }
    
    func setUpDummyData() {
        let option =  Options()
        dropDownMenu.optionArray = option.countries
//        dropDownMenu.optionIds = option.ids
    }
    
    func showCountryName(name: String) {
        print("Selected Country is: \(name)")
    }


}

