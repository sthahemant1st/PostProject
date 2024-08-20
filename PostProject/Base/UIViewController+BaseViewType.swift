//
//  UIViewController+BaseViewType.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import UIKit
import ProgressHUD

extension UIViewController: BaseViewType {
    func showProgressHud() {
        ProgressHUD.animate(interaction: false)
    }
    
    func hideProgressHud() {
        ProgressHUD.dismiss()
    }
    
    func alert(message: String?, title: String?, okAction: (() -> Void)?) {
        
    }
    
    func alertWithOkCancel(message: String?, title: String?, okTitle: String?, cancelTitle: String?, cancelStyle: UIAlertAction.Style, okAction: (() -> Void)?, cancelAction: (() -> Void)?) {
        
    }
    
}
