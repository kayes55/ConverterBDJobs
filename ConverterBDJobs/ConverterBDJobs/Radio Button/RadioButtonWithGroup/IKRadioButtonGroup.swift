//


import Foundation
import UIKit
protocol RadioButtonGroupDelegate {
    func radioButtonClicked(button: IKRadioButton)
}
class IKRadioButtonGroup {
    var delegate: RadioButtonGroupDelegate?
    var radioButtonsGroup = [String:[IKRadioButton]]()
        
    func appendToRadioGroup(radioButtons: [IKRadioButton]) {
        let totalGroups = radioButtonsGroup.keys.count
        let newGroupName = "group_\(totalGroups)"
        var buttonsInGroup = [IKRadioButton]()
        for button in radioButtons {
            button.addTarget(self, action: #selector(IKRadioButtonGroup.updateButtons(button:)), for:UIControl.Event.touchUpInside)
            button.radioGroupName = newGroupName
            buttonsInGroup.append(button)
        }
        buttonsInGroup = Array(Set(buttonsInGroup))
        radioButtonsGroup[newGroupName] = buttonsInGroup
    }
    
    @objc func updateButtons(button:IKRadioButton) {
        if let radioGroup = radioButtonsGroup[button.radioGroupName] {
            for lbutton in radioGroup {
                if lbutton != button {
                    lbutton.isRadioSelected = false
                } else {
                    lbutton.isRadioSelected = true
                }
            }
        }
        delegate?.radioButtonClicked(button: button)
    }
    
    func removeButtons() {
        radioButtonsGroup.removeAll()
    }
    
    
}
