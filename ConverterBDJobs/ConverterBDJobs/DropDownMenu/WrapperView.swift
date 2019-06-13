//
//  WrapperView.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/14/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import UIKit

protocol SendCountryNameDelegate: class {
    func showCountryName(name: String)
}

class WrapperView: UIView, UITextFieldDelegate {
    
    public static var delegate: SendCountryNameDelegate?
    
    @IBOutlet weak var dropDownView: Arrow! {
        didSet {
            addGesture()
        }
    }
    @IBOutlet weak var countryName: UILabel!
    
    var isSelected: Bool = false
    var table : UITableView!
    var shadow : UIView!
    
    public  var selectedIndex: Int?
    
    @IBInspectable public var rowHeight: CGFloat = 30
    @IBInspectable public var rowBackgroundColor: UIColor = .white
    @IBInspectable public var selectedRowColor: UIColor = .cyan
    @IBInspectable public var hideOptionsWhenSelect = true
    
    @IBInspectable public var listHeight: CGFloat = 150{
        didSet {
            
        }
    }
    
    //Variables
    fileprivate  var tableheightX: CGFloat = 100
    fileprivate  var dataArray = [String]()
    fileprivate  var imageArray = [String]()
    public var optionArray = [String]() {
        didSet{
            self.dataArray = self.optionArray
        }
    }
    public var optionImageArray = [String]() {
        didSet{
            self.imageArray = self.optionImageArray
        }
    }
    public var optionIds : [Int]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Closures
    fileprivate var didSelectCompletion: (String, Int ,Int) -> () = {selectedText, index , id  in }
    fileprivate var TableWillAppearCompletion: () -> () = { }
    fileprivate var TableDidAppearCompletion: () -> () = { }
    fileprivate var TableWillDisappearCompletion: () -> () = { }
    fileprivate var TableDidDisappearCompletion: () -> () = { }
    
    private func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        dropDownView.addGestureRecognizer(gesture)
    }
    
    @objc func tapAction() {
        if isSelected {
            hideList()
        } else {
            showList()
        }
        
    }
    
    //MARK:- TextFieldDelegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if isSelected {
            hideList()
        }
    }
}

extension WrapperView: UITableViewDelegate, UITableViewDataSource {
    public func showList() {
        
        TableWillAppearCompletion()
        if listHeight > rowHeight * CGFloat( dataArray.count) {
            self.tableheightX = rowHeight * CGFloat(dataArray.count)
        }else{
            self.tableheightX = listHeight
        }
        table = UITableView(frame: CGRect(x: self.frame.minX,
                                          y: self.frame.minY,
                                          width: self.frame.width,
                                          height: self.frame.height))
        shadow = UIView(frame: CGRect(x: self.frame.minX,
                                      y: self.frame.minY,
                                      width: self.frame.width,
                                      height: self.frame.height))
        shadow.backgroundColor = .clear
        
        table.dataSource = self
        table.delegate = self
        table.alpha = 0
        table.separatorStyle = .none
        table.layer.cornerRadius = 3
        table.backgroundColor = rowBackgroundColor
        table.rowHeight = rowHeight
        
        self.superview?.insertSubview(shadow, belowSubview: self)
        self.superview?.insertSubview(table, belowSubview: self)
        self.isSelected = true
        UIView.animate(withDuration: 0.9,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
                        
                        self.table.frame = CGRect(x: self.frame.minX,
                                                  y: self.frame.maxY+5,
                                                  width: self.frame.width,
                                                  height: self.tableheightX)
                        
                        self.table.alpha = 1
                        self.shadow.frame = self.table.frame
                        self.shadow.dropShadow()
                        self.dropDownView.position = .up
                        
        },
                       completion: { (finish) -> Void in
                        
        })
        
    }
    
    public func hideList() {
        
        TableWillDisappearCompletion()
        UIView.animate(withDuration: 1.0,
                       delay: 0.4,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
                        self.table.frame = CGRect(x: self.frame.minX,
                                                  y: self.frame.minY,
                                                  width: self.frame.width,
                                                  height: 0)
                        self.shadow.alpha = 0
                        self.shadow.frame = self.table.frame
                        self.dropDownView.position = .down
        },
                       completion: { (didFinish) -> Void in
                        
                        self.shadow.removeFromSuperview()
                        self.table.removeFromSuperview()
                        self.isSelected = false
                        self.TableDidDisappearCompletion()
        })
    }
    
    func reSizeTable() {
        if listHeight > rowHeight * CGFloat( dataArray.count) {
            self.tableheightX = rowHeight * CGFloat(dataArray.count)
        }else{
            self.tableheightX = listHeight
        }
        UIView.animate(withDuration: 0.2,
                       delay: 0.1,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
                        self.table.frame = CGRect(x: self.frame.minX,
                                                  y: self.frame.maxY+5,
                                                  width: self.frame.width,
                                                  height: self.tableheightX)
                        
                        
        },
                       completion: { (didFinish) -> Void in
                        self.shadow.layer.shadowPath = UIBezierPath(rect: self.table.bounds).cgPath
                        
        })
    }
    
    //MARK: Actions Methods
    public func didSelect(completion: @escaping (_ selectedText: String, _ index: Int , _ id:Int ) -> ()) {
        didSelectCompletion = completion
    }
    
    public func listWillAppear(completion: @escaping () -> ()) {
        TableWillAppearCompletion = completion
    }
    
    public func listDidAppear(completion: @escaping () -> ()) {
        TableDidAppearCompletion = completion
    }
    
    public func listWillDisappear(completion: @escaping () -> ()) {
        TableWillDisappearCompletion = completion
    }
    
    public func listDidDisappear(completion: @escaping () -> ()) {
        TableDidDisappearCompletion = completion
    }
    
    
    //MARK:- Delegates and DataSource Methods
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DropDownCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        if indexPath.row != selectedIndex{
            cell!.backgroundColor = rowBackgroundColor
        }else {
            cell?.backgroundColor = selectedRowColor
        }
        
        if self.imageArray.count > indexPath.row {
            cell!.imageView!.image = UIImage(named: imageArray[indexPath.row])
        }
        cell!.textLabel!.text = "\(dataArray[indexPath.row])"
        cell!.accessoryType = indexPath.row == selectedIndex ? .checkmark : .none
        cell!.selectionStyle = .none
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = (indexPath as NSIndexPath).row
        let selectedText = self.dataArray[self.selectedIndex!]
        tableView.cellForRow(at: indexPath)?.alpha = 0
        UIView.animate(withDuration: 0.5,
                       animations: { () -> Void in
                        tableView.cellForRow(at: indexPath)?.alpha = 1.0
                        tableView.cellForRow(at: indexPath)?.backgroundColor = self.selectedRowColor
        } ,
                       completion: { (didFinish) -> Void in
                        self.countryName.text = "\(selectedText)"
                        WrapperView.delegate?.showCountryName(name: selectedText)
                        
                        tableView.reloadData()
        })
        if hideOptionsWhenSelect {
            tapAction()
        }
        if let selected = optionArray.firstIndex(where: {$0 == selectedText}) {
            if let id = optionIds?[selected] {
                didSelectCompletion(selectedText, selected , id )
            }else{
                didSelectCompletion(selectedText, selected , 0)
            }
            
        }
        
    }
}


extension UIView {
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 2
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
}
