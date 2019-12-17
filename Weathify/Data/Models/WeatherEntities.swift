//
//  city_weather.swift
//  Weathify
//
//  Created by Tigran Sarkisyan on 12/5/19.
//  Copyright © 2019 Tigran Sarkisyan. All rights reserved.
//

import Foundation

struct WeatherList: Codable {
    let list: [CityWeather]?
}

class CityWeather: Codable {
    let weather: [Weather]?
    let main: WeatherMain?
    let dt_txt: String?
}

struct Weather: Codable {
    let main: String?
    let icon: String?
}

struct WeatherMain: Codable {
    let temp: Double?
}
