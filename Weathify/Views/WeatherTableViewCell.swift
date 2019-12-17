//
//  WeatherTableViewCell.swift
//  Weathify
//
//  Created by Tigran Sarkisyan on 12/10/19.
//  Copyright © 2019 Tigran Sarkisyan. All rights reserved.
//

import UIKit
import Kingfisher

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherDateLabel: UILabel!
    @IBOutlet weak var weatherValueLabel: UILabel!
    
    func setup(cityWeather: CityWeather) {
        weatherDateLabel?.text = cityWeather.dt_txt
        weatherValueLabel?.text = String(cityWeather.main!.temp!)
        weatherImageView.kf.setImage(with: URL(string: "http://openweathermap.org/img/wn/\(cityWeather.weather![0].icon!)@2x.png")!)
    }
    
}
