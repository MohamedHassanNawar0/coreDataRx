//
//  Memo.swift
//  MyMVVMRxSwiftExample
//
//  Created by Mohamed Nawar on 3/28/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import Foundation

struct Memo: Equatable {
    var content: String
    var insertData: Date
    var identity: String
    
    init(content: String, insertData: Date) {
        self.content = content
        self.insertData = insertData
        self.identity = "\(insertData.timeIntervalSinceReferenceDate)"
    }
    
    init(orignal:Memo, updateContent: String) {
        self = orignal
        self.content = updateContent
    }
}
