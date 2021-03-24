//
//  ControllerViewModel.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import Foundation

class ControllerViewModel {
    var showAlert: ((_ title: String, _ message: String, _ buttonTitle: String, _ onButtonPress: (() -> Void)?) -> Void)?
}
