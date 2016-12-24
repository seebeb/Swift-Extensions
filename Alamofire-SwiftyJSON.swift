//
//  Alamofire-SwiftyJSON.swift
//
//  Created by Augus on 9/25/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

extension DataRequest {

    @discardableResult
    public func responseSwiftyJSON(
        queue: DispatchQueue? = nil,
        options: JSONSerialization.ReadingOptions = .allowFragments,
        completionHandler:@escaping (URLRequest, HTTPURLResponse?, SwiftyJSON.JSON, Error?) -> ())
        -> Self {

        return response(queue: queue, responseSerializer: DataRequest.jsonResponseSerializer(options: options), completionHandler: { (response) in

            DispatchQueue.global(qos: .default).async(execute: {

                var responseJSON: JSON

                if response.result.isFailure
                {
                    responseJSON = JSON.null
                } else {
                    responseJSON = SwiftyJSON.JSON(response.result.value!)
                }
                
                (queue ?? DispatchQueue.main).async(execute: {
                    completionHandler(response.request!, response.response, responseJSON, response.result.error)
                })
            })
        })
    }

    @discardableResult
    public func responseSwiftyJSON(_ completionHandler: @escaping (URLRequest, HTTPURLResponse?, SwiftyJSON.JSON, Error?) -> ()) -> Self {
        return responseSwiftyJSON(options: .allowFragments, completionHandler: completionHandler)
    }

    @discardableResult
    public func responseSwiftyJSON(_ completionHandler: @escaping (SwiftyJSON.JSON, Error?) -> ()) -> Self {
        return responseSwiftyJSON({ (_, _, json, error) in
            completionHandler(json, error)
        })
    }
}
