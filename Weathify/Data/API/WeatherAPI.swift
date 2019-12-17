//
//  WeatherAPI.swift
//  Weathify
//
//  Created by macbook-097 on 12/16/19.
//  Copyright © 2019 Tigran Sarkisyan. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class WeatherAPI {
    
    static func getWeatherListPerHour(cityName: String) -> Observable<WeatherList> {
        // return (request(url))
        return AF
            .request("\(APIConfigs.URL.BASE_URL)data/2.5/forecast?q=\(cityName)&apikey=\(APIConfigs.URL.WEATHER_API_KEY)")
            .rx
            .responseDecodable()
    }
    
    static func getCityCurrentWeatherAndImage(cityName: String) -> Observable<CityWeather> {
        return AF
            .request("\(APIConfigs.URL.BASE_URL)data/2.5/weather?q=\(cityName)&apikey=\(APIConfigs.URL.WEATHER_API_KEY)")
            .rx
            .responseDecodable()
    }
    
    //    private static func request<T: Codable> (_ urlConvertible: String) -> Observable<T> {
    //        return Observable<T>.create { observer in
    //            let request = AF
    //                .request(urlConvertible)
    //                .responseDecodable { (response: DataResponse<T, AFError>) in
    //                    switch response.result {
    //                    case .success(let value):
    //                        observer.onNext(value)
    //                        observer.onCompleted()
    //                    case .failure(let error):
    //                        observer.onError(error)
    //                    }
    //            }
    //
    //            return Disposables.create {
    //                request.cancel()
    //            }
    //        }
    //    }
    
}

