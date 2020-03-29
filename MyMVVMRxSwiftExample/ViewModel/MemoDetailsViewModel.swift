//
//  MemoDetailsViewModel.swift
//  MyMVVMRxSwiftExample
//
//  Created by Mohamed Nawar on 3/28/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Action
import NSObject_Rx

class MemoDetailViewModel: CommonViewModel {
    var memo: Memo
    var contents: BehaviorSubject<[String]>

    private var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    init(memo: Memo, title: String, sceneCoordinator: SceneCoordinatorType, storage: MemostorageType) {
        self.memo = memo
        contents = BehaviorSubject<[String]>(value: [
            memo.content,
            formatter.string(from: memo.insertDate)
        ])
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
    
    lazy var popAction = CocoaAction { _ in
       return self.sceneCoordinator.close(animated: true).asObservable().map{ _ in }
     }
    
    func performUpdate(memo: Memo) -> Action<String, Void> {
      return Action { input in
        self.storage.update(memo: memo, content: input)
          .subscribe(onNext: {
            self.memo = $0
            self.contents.onNext([
              $0.content,
              self.formatter.string(from: $0.insertDate)
            ])
          }).disposed(by: self.rx.disposeBag)

        return Observable.empty()
      }
    }

    func makeEditAction() -> CocoaAction {
      return CocoaAction { _ in
        let composeViewModel = MemoComposeViewModel(title: "Edit",
                                                    content: self.memo.content,
                                                    sceneCoordinator: self.sceneCoordinator,
                                                    storage: self.storage,
                                                    saveAction: self.performUpdate(memo: self.memo))
        let composeScene = Scene.compose(composeViewModel)
        return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map { _ in }
      }
    }

    func makeDeleteAction() -> CocoaAction {
      return Action { input in
        self.storage.delete(memo: self.memo)
        return self.sceneCoordinator.close(animated: true).asObservable().map { _ in }
      }
    }

}

