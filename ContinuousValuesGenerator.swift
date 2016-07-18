//
//  ContinuousValuesGenerator.swift
//
//  Created by Augus on 6/29/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


class ContinuousValuesGenerator<T: Arithmetic> {

    private var currentValue: T
    
    /// Animated Value Generator
    ///
    /// - parameter startValue:     start value
    /// - parameter endValue:       end value
    /// - parameter offsetPerTime:  offset per time. Positive / Negative number makes no matter !!
    /// - parameter generatedValue: new generated nember per time
    /// - parameter completion:     completion closure
    @discardableResult
    init(startValue: T, endValue: T, offsetPerTime: T, generatedValue: ((T) -> ()), completion: Closure? = nil) {
        
        currentValue = startValue
        
        let totalOffset = (endValue - startValue).double
        
        guard abs(totalOffset) > abs(offsetPerTime.double) else {
            generatedValue(endValue)
            completion?()
            return
        }
        
        let realOffsetPerTime = T(totalOffset > 0 ? abs(offsetPerTime.double) : -abs(offsetPerTime.double))
        
        run(start: startValue, end: endValue, offset: realOffsetPerTime, generated: generatedValue, completion: completion)
    }
    
    // recursion
    private func run(start: T, end: T, offset: T, generated: ((T) -> ()), completion: Closure? = nil) {
                
        guard (offset.double > 0) ? currentValue < end : currentValue > end else {
            
            if currentValue != end { generated(end) }
            
            completion?()
            return
        }
        
        currentValue += offset
        
        generated(currentValue)
        
        run(start: currentValue, end: end, offset: offset, generated: generated, completion: completion)
    }
}


class ContinuousValuesGeneratorWithDuration<T: Arithmetic> {
    
    private var times: Int
    private var startValue: T
    private var endValue: T
    private var offsetPerTime: T
    private var completionHandler: Closure?
    private var generatedValueHandler: ((T) -> ())
    
    
    /// Animated Value Generator
    ///
    /// - parameter duration:       duration time
    /// - parameter startValue:     start value
    /// - parameter endValue:       end value
    /// - parameter offsetPerTime:  offset per time. Positive / Negative number makes no matter !!
    /// - parameter generatedValue: new generated nember per time
    /// - parameter completion:     completion closure
    @discardableResult
    init(_ duration: TimeInterval, startValue: T, endValue: T, offsetPerTime: T, generatedValue: ((T) -> ()), completion: Closure? = nil) {
        
        let times = (endValue - startValue) / offsetPerTime
        self.times = abs(times.int)
        self.startValue = startValue
        self.endValue = endValue
        self.offsetPerTime = times.int >= 0 ? offsetPerTime : -offsetPerTime
        self.generatedValueHandler = generatedValue
        
        if self.times < 1 {
            generatedValue(endValue)
            completion?()
            
            #if DEBUG
                print("Animated Value Generator: Only executed once")
            #endif

            return
        }
        
        let tempTotalTimes = self.times
        let interval = duration / Double(self.times)
        
        #if DEBUG
            let note = endValue.double != 0 && endValue.double < 0.0001 ? " (Attention: About 0)" : ""
            print("\n" + "###########  Animated Value Generator  #############" + "\n")
            print("Start value: \(startValue)")
            print("End value: \(endValue)" + note)
            print("Offset per time: \(self.offsetPerTime)")
            print("Duration: \(duration)")
            print("Interval: \(interval)")
            print("Total times: \(tempTotalTimes)")
            print("\n" + "###########  Animated Value Generator  #############" + "\n")
        #endif
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(run(_:)), userInfo: nil, repeats: true).fire()
        
        completionHandler = completion
    }
    
    @objc private func run(_ timer: Timer) {
        
        #if DEBUG
            
            let output: (T) -> () = {
                print("Animated Value Generator - Current Value: \($0)")
            }
            
            output(startValue)
            
        #endif
        
        guard times > 0 else {
            timer.invalidate()
            
            if startValue != endValue {
                
                generatedValueHandler(endValue)
                
                #if DEBUG
                    output(endValue)
                #endif
            }
            
            completionHandler?()
            return
        }
        
        startValue += offsetPerTime
        generatedValueHandler(startValue)
        times -= 1
    }
    
}

