//
//  constants.swift
//  Weathify
//
//  Created by Tigran Sarkisyan on 12/10/19.
//  Copyright © 2019 Tigran Sarkisyan. All rights reserved.
//

import Foundation

struct APIConfigs {
    
    enum URL {
        static let BASE_URL = "http://api.openweathermap.org/"
        static let WEATHER_API_KEY = "8df903ce56f6d18245e72f380beb297d"
        static func WEATHER_IMAGE_URL(icon: String) -> String { return "http://openweathermap.org/img/wn/\(icon)@2x.png" }
    }
    
}
