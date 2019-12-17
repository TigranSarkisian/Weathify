//
//  weather_manager.swift
//  Weathify
//
//  Created by Tigran Sarkisyan on 12/10/19.
//  Copyright © 2019 Tigran Sarkisyan. All rights reserved.
//

import Foundation
import SwiftyBeaver
import RxSwift
import RxCocoa
import Alamofire

class WeatherDataManager {
    
    private let disposeBag = DisposeBag()
    
    func getWeatherListPerHour(
        success: @escaping (_ weatherForecast: [CityWeather]) -> Void,
        failure: ((_ error: String) -> Void)? = nil
    ) {
        WeatherAPI.getWeatherListPerHour(cityName: "Minsk")
            .observeOn(MainScheduler.instance)
            .map { data in data.list!}
            .catchErrorJustReturn([CityWeather]())
            .subscribe(onNext: { data in
                success(data)
            }, onError: { error in
                failure!("Failed to parse data!")
            })
            .disposed(by: disposeBag)
    }
    
    func getCityCurrentWeatherAndImage(
        success: @escaping (_ currentTemp: String, _ weatherImageUrl: URL) -> Void,
        failure: ((_ error: String) -> Void)? = nil
    ) {
        WeatherAPI.getCityCurrentWeatherAndImage(cityName: "Minsk")
            .observeOn(MainScheduler.instance)
            .map { cityWeather -> (String, URL?)  in
                let currentTemp = String(format: "%.2f C", cityWeather.main!.temp! - 273)
                let weatherImageUrl = URL(string: APIConfigs.URL.WEATHER_IMAGE_URL(icon: cityWeather.weather![0].icon!))
                return (currentTemp, weatherImageUrl)
        }
        .subscribe(onNext: { data in
            success(data.0, data.1!)
        }, onError: { error in
            failure!("Failed to parse data")
        })
            .disposed(by: disposeBag)
    }
    
}
