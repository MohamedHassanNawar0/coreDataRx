//
//  Scene.swift
//  MyMVVMRxSwiftExample
//
//  Created by Mohamed Nawar on 3/28/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import UIKit

enum Scene {
    case list(MemoListViewModel)
    case details(MemoDetailsViewModel)
    case compose(MemoComposeViewModel)
}

extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .list(let viewModel):
            guard let nav = storyboard.instantiateViewController(identifier: "ListNav") as? UINavigationController else {
                fatalError()
            }
            
            guard var listVC = nav.viewControllers.first as? MemoListVC else {
                fatalError()
            }
            
            listVC.bind(viewModel: viewModel)
            return nav
        case .details(let viewModel):
            guard var detailsVc = storyboard.instantiateViewController(identifier: "DetailsVC") as? MemoDetailsVC else {
                fatalError()
            }
            
            detailsVc.bind(viewModel: viewModel)
            return detailsVc
        case .compose(let viewModel):
            guard let nav = storyboard.instantiateViewController(identifier: "ComposeNv") as? UINavigationController else {
                fatalError()
            }
            
            guard var composeVC = nav.viewControllers.first as? MemoComposeVC else {
                fatalError()
            }
            
            composeVC.bind(viewModel: viewModel)
            return composeVC
        default:
            print("ee")
        }
        return UINavigationController()
    }
}
