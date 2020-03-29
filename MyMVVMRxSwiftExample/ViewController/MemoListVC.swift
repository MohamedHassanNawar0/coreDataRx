//
//  MemoListVC.swift
//  MyMVVMRxSwiftExample
//
//  Created by Mohamed Nawar on 3/28/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

class MemoListVC: UIViewController, ViewModelBindbleType {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var listTableView: UITableView!
    var viewModel: MemoListViewModel!
            
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.memoList.bind(to: listTableView.rx.items(cellIdentifier: "cell")) {
            row, memo, cell in
            cell.textLabel?.text = memo.content
        }.disposed(by: rx.disposeBag)
        
        addButton.rx.action = viewModel.makeCreateAction()
        
        Observable.zip(listTableView.rx.modelSelected(Memo.self),
                       listTableView.rx.itemSelected)
          .do(onNext: { [weak self] (_, indexPath) in
            self?.listTableView.deselectRow(at: indexPath, animated: true)
          })
          .map { $0.0 }
          .bind(to: viewModel.detailAction.inputs)
          .disposed(by: rx.disposeBag)
    }
 
}
