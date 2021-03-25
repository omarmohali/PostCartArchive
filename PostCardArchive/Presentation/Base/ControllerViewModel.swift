//
//  ControllerViewModel.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import Foundation
import UIKit

class ControllerViewModel {
    var showAlert: ((_ title: String, _ message: String, _ buttonTitle: String, _ onButtonPress: (() -> Void)?) -> Void)?
    var showConfirmAlert: ((_ title: String, _ message: String, _ cancelButtonTitle: String, _ confirmButtonTitle: String, _ onCancel: (() -> Void)?, _ onConfirm: (() -> Void)?) -> Void)?
    var pushViewController: ((_ viewController: UIViewController, _ animated: Bool) -> Void)?
    var popViewController: ((_ animated: Bool) -> Void)?
    var presentViewController: ((_ viewController: UIViewController, _ animated: Bool, _ completion: (() -> Void)?) -> Void)?
    var dismissViewController: ((_ animated: Bool, _ completion: (() -> Void)?) -> Void)?
}
