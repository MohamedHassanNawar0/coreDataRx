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
  case detail(MemoDetailViewModel)
  case compose(MemoComposeViewModel)
}

extension Scene {

  func instantiate(from storyboard: String = "Main") -> UIViewController {
    let storyboard = UIStoryboard(name: storyboard, bundle: nil)

    switch self {
    case .list(let viewModel):
      guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNav") as? UINavigationController else {
        fatalError()
      }

      guard var listVC = nav.viewControllers.first as? MemoListVC else {
        fatalError()
      }

      listVC.bind(viewModel: viewModel)
      return nav

    case .detail(let viewModel):
      guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? MemoDetailsVC else {
        fatalError()
      }

      detailVC.bind(viewModel: viewModel)
      return detailVC

    case .compose(let viewModel):
      guard let nav = storyboard.instantiateViewController(withIdentifier: "ComposeNav") as? UINavigationController else {
        fatalError()
      }

      guard var composeVC = nav.viewControllers.first as? MemoComposeVC else {
        fatalError()
      }

      composeVC.bind(viewModel: viewModel)
      return nav

    }
  }
}

extension UIViewController {
  var sceneViewController: UIViewController {
    return self.children.first ?? self
  }
}
