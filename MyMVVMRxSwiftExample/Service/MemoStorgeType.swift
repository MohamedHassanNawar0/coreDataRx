//
//  MemoStorgeType.swift
//  MyMVVMRxSwiftExample
//
//  Created by Mohamed Nawar on 3/28/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import Foundation
import RxSwift

protocol MemostorageType {
    @discardableResult
    func createMemo(content: String) -> Observable<Memo>
    
    @discardableResult
    func memoList() -> Observable<[Memo]>
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo>

    @discardableResult
    func delete(memo: Memo) -> Observable<Memo>
}
