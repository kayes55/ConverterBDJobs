//
//  IKPlaceholder.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/14/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import UIKit

public class IKPlaceholder: UITextField, UITextFieldDelegate {

    @IBInspectable public var subjectColor: UIColor = UIColor.black
    @IBInspectable public var underLineColor: UIColor = UIColor.black
    
    fileprivate let placeholderLabelFontSize: CGFloat = 12.0
    fileprivate var placeholderLabel: UILabel?
    fileprivate var titlePlaceholder: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    override public func draw(_ rect: CGRect) {
        drawUnderLine()
        self.clipsToBounds = false
        self.borderStyle = .none
    }
    
    fileprivate func drawUnderLine() {
        
        let underLineView = UIView(frame: CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1))
        let underLineView1 = UIView(frame: CGRect(x: 0, y: -1, width: 1, height: frame.size.height))
        let underLineView2 = UIView(frame: CGRect(x: frame.size.width, y: -1, width: 1, height: frame.size.height))
        let underLineView3 = UIView(frame: CGRect(x: 0, y: -1, width: frame.size.width, height: 1))
        underLineView.backgroundColor = underLineColor
        underLineView1.backgroundColor = underLineColor
        underLineView2.backgroundColor = underLineColor
        underLineView3.backgroundColor = underLineColor
        
        self.addSubview(underLineView)
        self.addSubview(underLineView1)
        self.addSubview(underLineView2)
        self.addSubview(underLineView3)
        
    }
    
}
