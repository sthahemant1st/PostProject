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
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                okAction?()
            }
        )
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alertWithOkCancel(
        message: String?,
        title: String?,
        okTitle: String?,
        cancelTitle: String?,
        cancelStyle: UIAlertAction.Style,
        okAction: (() -> Void)?,
        cancelAction: (() -> Void)?
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: okTitle,
            style: .default,
            handler: { _ in
                okAction?()
            }
        )
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(
            title: cancelTitle,
            style: .default,
            handler: { _ in
                cancelAction?()
            }
        )
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
