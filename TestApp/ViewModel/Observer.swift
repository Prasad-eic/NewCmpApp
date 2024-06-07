//
//  Observer.swift
//  TestApp
//
//  Created by Prasad Lokhande on 07/06/24.
//

import Foundation

class Observable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }

    private var observer: ((T?) -> Void)?

    func bind(observer: @escaping (T?) -> Void) {
        self.observer = observer
        observer(value)
    }
}
