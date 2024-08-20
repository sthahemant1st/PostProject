//
//  BaseViewType.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import UIKit

protocol BaseViewType: AnyObject {
    func showProgressHud()
    func hideProgressHud()
    func alert(message: String?, title: String?, okAction: (() -> Void)?)
    func alertWithOkCancel(message: String?,
                           title: String?,
                           okTitle: String?,
                           cancelTitle: String?,
                           cancelStyle: UIAlertAction.Style,
                           okAction: (() -> Void)?,
                           cancelAction: (() -> Void)?)
}
