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
    let memo: Memo
    
    private var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    var contents: BehaviorSubject<[String]>
    
    init(memo: Memo, title: String, sceneCoordinator: SceneCoordinatorType, storage: MemostorageType) {
        self.memo = memo
        content = BehaviorSubject<[String]>(value: [
            memo.content,
            formatter.string(from: memo.insertData)
        ])
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
    
    
}
