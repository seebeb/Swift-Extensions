//
//  DurationGenerator.swift
//
//  Created by Augus on 6/29/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


class DurationGenerator {
    
    var isStopped = false

    private var times: Int
    private var todoHandler: Closure
    
    private var completionhandler: Closure?
    private var StopCondition: (() -> Bool)?
    
    init(todo: Closure, times: Int) {
        self.todoHandler = todo
        self.times = times
    }

    convenience init(duration: TimeInterval, times: Int, todo: Closure, completion: Closure? = nil) {
        self.init(todo: todo, times: times)
        
        Timer.scheduledTimer(timeInterval: duration / TimeInterval(times), target: self, selector: #selector(run(_:)), userInfo: nil, repeats: true)

        completionhandler = completion
    }
    
    convenience init(interval: TimeInterval, times: Int, todo: Closure, completion: Closure? = nil) {
        self.init(todo: todo, times: times)
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(run(_:)), userInfo: nil, repeats: true)
        
        completionhandler = completion
    }
    
    @objc private func run(_ timer: Timer) {
        
        guard times > 0 || !isStopped else {
            timer.invalidate()
            completionhandler?()
            return
        }
        
        todoHandler()
        times -= 1
    }
}
