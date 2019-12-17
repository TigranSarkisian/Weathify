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
        
        //        AF
        //            .request(UrlConstants.getWeatherListUrl(cityName: "Minsk"))
        //            .responseDecodable { (response: DataResponse<WeatherList, AFError>) in
        //                do {
        //                    let weatherList = try response.result.get().list!
        //                    success(weatherList)
        //                } catch let error {
        //                    SwiftyBeaver.error("Failed to parse data \(error.localizedDescription)")
        //                }
        //        }
        
        
        //        AF
        //            .request(UrlConstants.getWeatherListUrl(cityName: "Minsk"))
        //            .responseJSON { response in
        //                switch response.result {
        //                case .success(_):
        //                    guard let jsonData = response.data else {
        //                        SwiftyBeaver.error("Failed to load data")
        //                        failure!("Failed to load data")
        //                        return
        //                    }
        //
        //                    do {
        //                        let weatherList = try JSONDecoder().decode(WeatherList.self, from: jsonData)
        //
        //                        if !weatherList.list!.isEmpty {
        //                            success(weatherList.list!)
        //                        } else {
        //                            failure!("Failed to load weather list")
        //                        }
        //
        //                    } catch let error {
        //                        SwiftyBeaver.error(error.localizedDescription)
        //                        failure!("Failed to parse data")
        //                    }
        //
        //                case .failure(_):
        //                    SwiftyBeaver.error("Error by loading data")
        //                    failure!("Failed to load weather list")
        //                }
        //        }
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
    
    //    func getCityCurrentWeatherAndImage(
    //        success: @escaping (_ currentTemp: String, _ weatherImageUrl: URL) -> Void,
    //        failure: ((_ error: String) -> Void)? = nil
    //    ) {
    //        AF
    //            .request(UrlConstants.getCurrentWeatherUrl(cityName: "Minsk"))
    //            .responseJSON { response in
    //                switch response.result {
    //                case .success(_):
    //                    guard let jsonData = response.data else {
    //                        SwiftyBeaver.error("Failed to load data")
    //                        failure!("Failed to load data")
    //                        return
    //                    }
    //
    //                    do {
    //                        let cityWeather = try JSONDecoder().decode(CityWeather.self, from: jsonData)
    //                        let currentTemp = String(format: "%.2f C", cityWeather.main!.temp! - 273)
    //                        let weatherImageUrl = URL(string: UrlConstants.getWeatherImageUrl(icon: cityWeather.weather![0].icon!))
    //                        success(currentTemp, weatherImageUrl!)
    //
    //                    } catch let error {
    //                        SwiftyBeaver.error("Failed to parse data \(error.localizedDescription)")
    //                        failure!("Failed to parse data")
    //                    }
    //                case .failure(_):
    //                    SwiftyBeaver.error("Error by loading data")
    //                    failure!("Failed to load weather list")
    //                }
    //        }
    //    }
    
}
