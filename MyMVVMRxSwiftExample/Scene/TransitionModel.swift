//
//  TransitionModel.swift
//  MyMVVMRxSwiftExample
//
//  Created by Mohamed Nawar on 3/28/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case model
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
