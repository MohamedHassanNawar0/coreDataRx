//
//  MemoListViewModel.swift
//  MyMVVMRxSwiftExample
//
//  Created by Mohamed Nawar on 3/28/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoListViewModel: CommonViewModel {
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
    
    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            return self.storage.update(memo: memo, content: input).map{ _ in }
        }
    }
    
    func performCancel(memo: Memo) -> CocoaAction {
        return Action {
            return self.storage.delete(memo: memo).map{ _ in }
        }
    }
    
    func makeCreateAction() -> CocoaAction {
        return CocoaAction { _ in
            return self.storage.createMemo(content: "")
                .flatMap { memo -> Observable<Void> in
                    let composedViewModel = MemoComposeViewModel(title: "Add Memo", sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: memo), cancelAction: self.performCancel(memo: memo))
                    let composeScene = Scene.compose(composedViewModel)
                    return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map{ _ in }
            }
            
        }
    }
    
    lazy var detailAction: Action<Memo, Void> = {
      return Action { memo in

        let detailViewModel = MemoDetailViewModel(memo: memo, title: "Details", sceneCoordinator: self.sceneCoordinator, storage: self.storage)

        let detailScene = Scene.detail(detailViewModel)
        return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map { _ in }
      }
    }()
}
