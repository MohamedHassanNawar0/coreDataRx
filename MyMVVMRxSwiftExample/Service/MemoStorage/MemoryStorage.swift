//
//  MemoryStorage.swift
//  MyMVVMRxSwiftExample
//
//  Created by Mohamed Nawar on 3/28/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import Foundation
import RxSwift

class MemoryStorage: MemostorageType {
    private var list = [
        Memo(content: "Hellow, RxSwift", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Lorem Ispum", insertDate: Date().addingTimeInterval(-20))
    ]
    
    private lazy var store = BehaviorSubject<[Memo]>(value: list)
    
    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content, insertDate: Date().addingTimeInterval(-10))
        list.insert(memo, at: 0)
        store.onNext(list)
        return Observable.just(memo)
    }
    
    @discardableResult
    func memoList() -> Observable<[Memo]> {
        return store
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updateMemo = Memo(original: memo, updatedContent: content)
        
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
            list.insert(updateMemo, at: index)
        }
        store.onNext(list)
        return Observable.just(updateMemo)
    }
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
        }
        store.onNext(list)
        return Observable.just(memo)
    }
}
