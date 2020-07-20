//
//  AsyncOperation.swift
//  DatingApp
//
//  Created by Vy Le on 7/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class AsyncOperation: Operation {
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    // MARK: - Override Properties
    override var isReady: Bool {
        super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        state == .executing
    }
    
    override var isFinished: Bool {
        state == .finished
    }
    
    override func cancel() {
        state = .finished
    }
    
    override var isAsynchronous: Bool {
        true
    }
    
    // MARK: - Override Function
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        state = .executing
    }
}

extension AsyncOperation {
    enum State: String {
        case ready, executing, finished
        
        fileprivate var keyPath: String {
            "is\(rawValue.capitalized)"
        }
    }
}

class AsyncResultOperation<Success, Failure>: AsyncOperation where Failure: Error {
    var result: Result<Success, Failure>?
    
    func finish(with result: Result<Success, Failure>) {
        self.result = result
        super.state = .finished
    }
    
    func cancel(with error: Failure) {
        self.result = .failure(error)
        super.cancel()
    }
}
