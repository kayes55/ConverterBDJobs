//
//  ShowProgress.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/16/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import Foundation
import SVProgressHUD

class ShowProgress {
    
    public static let shared = ShowProgress()
    
    private init() {}
    
    public func showProgressHUD() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.show()
    }
    
    public func dismissProgressHUD() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss(withDelay: 1.0)
        }
    }
    
}
