//
//  Network.swift
//  Worker
//
//  Created by HoJun Lee on 2017. 11. 23..
//  Copyright © 2017년 HoJun Lee. All rights reserved.
//

import Domain
import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import ObjectMapper

final class Network<T: ImmutableMappable> {
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    init() {
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    func getItems(_ absolutePath: String) -> Observable<[T]> {
        return RxAlamofire
            .json(.get, absolutePath)
            .debug()
            .observeOn(scheduler)
            .map({ json -> [T] in
                return try Mapper<T>().mapArray(JSONObject: json)
            })
    }
    
    func getItem(_ absolutePath: String) -> Observable<T> {
        return RxAlamofire
            .request(.get, absolutePath)
            .debug()
            .observeOn(scheduler)
            .map({ json -> T in
                return try Mapper<T>().map(JSONObject: json)
            })
    }
    
    func postItem(_ absolutePath: String, parameters: [String: Any]) -> Observable<T> {
        return RxAlamofire
            .request(.post, absolutePath, parameters: parameters)
            .debug()
            .observeOn(scheduler)
            .map({ json -> T in
                return try Mapper<T>().map(JSONObject: json)
            })
    }
    
    func updateItem(_ absolutePath: String, parameters: [String: Any]) -> Observable<T> {
        return RxAlamofire
            .request(.put, absolutePath, parameters: parameters)
            .debug()
            .observeOn(scheduler)
            .map({ json -> T in
                return try Mapper<T>().map(JSONObject: json)
            })
    }
    
    func deleteItem(_ absolutePath: String) -> Observable<T> {
        return RxAlamofire
            .request(.delete, absolutePath)
            .debug()
            .observeOn(scheduler)
            .map({ json -> T in
                return try Mapper<T>().map(JSONObject: json)
            })
    }
}


