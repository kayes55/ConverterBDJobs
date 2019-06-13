//
//  ViewController.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/13/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RadioButtonGroupDelegate {
    
    
    @IBOutlet weak var standardBtn: IKRadioButton!
    @IBOutlet weak var superBtn: IKRadioButton!
    @IBOutlet weak var reduceBtn: IKRadioButton!
    
    var radioButtonGroup: IKRadioButtonGroup!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButtonGroup = IKRadioButtonGroup()
        radioButtonGroup.delegate = self
        radioButtonGroup.appendToRadioGroup(radioButtons: [standardBtn,superBtn, reduceBtn])
                
    }
    
    func radioButtonClicked(button: IKRadioButton) {
        print(button.tag)
    }


}

