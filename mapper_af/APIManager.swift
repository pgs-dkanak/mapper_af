//
//  APIManager.swift
//  mapper_af
//
//  Created by pgs-dkanak on 22/10/16.
//  Copyright © 2016 pgs-dkanak. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift

class APIManager {
    
    let flightsUrl = "https://api.myjson.com/bins/w60i"
    
    func requestFlights() -> Void { //TODO: Flights
        request(flightsUrl,
                method: .get).responseString { (responseString: DataResponse<String>) in
//                    print(responseString)
                    if let responseText = responseString.result.value {
                        print(responseText)
                        let mapper = Mapper<Flight>()
                        let flights = mapper.mapArray(JSONString: responseText)
                        print(flights)
                    }
                    
        }
    }
    
    func requestFlights2() -> Observable<[Flight]> {
        return Observable.create({ (subscriber: AnyObserver<[Flight]>) -> Disposable in
            let req = request(self.flightsUrl, method: .get).responseString(completionHandler: {
                (responseString: DataResponse<String>) in
                print(responseString)
                if let error = responseString.result.error {
                    subscriber.onError(error)
                }
                if let responseText = responseString.result.value {
                    print(responseText)
                    let mapper = Mapper<Flight>()
                    let flights = mapper.mapArray(JSONString: responseText) ?? []
                    print(flights)
                    subscriber.onNext(flights)
                }
            })
            return Disposables.create {
                req.cancel()
            }
        })
    }
    
    func requestFlights3() -> Void {
        request(flightsUrl, method: .get).responseJSON { (responseJSON: DataResponse<Any>) in
            if let json = responseJSON.result.value {
                print(json)
                let mapper = Mapper<Flight>()
                let flights = mapper.mapArray(JSONObject: json)
                print(flights)
            }
        }
    }
    
    func requestFlights4() -> Observable<[Flight]> {
        
        return Observable.create { (subscriber: AnyObserver<[Flight]>) -> Disposable in
            
            let req = request(self.flightsUrl, method: .get).responseJSON(completionHandler: {
                (responseJSON: DataResponse<Any>) in
//                if let error = responseJSON.result.error {
//                    subscriber.onError(error)
//                } else
                
                if let json = responseJSON.result.value {
                    let mapper = Mapper<Flight>()
                    let flights = mapper.mapArray(JSONObject: json)
                    subscriber.onNext(flights ?? [])
                }
                subscriber.onCompleted()
            })
            
            return Disposables.create {
                req.cancel()
            }
        }
    }
    
 
}
