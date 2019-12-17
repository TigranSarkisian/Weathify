//
//  ViewController.swift
//  Weathify
//
//  Created by Tigran Sarkisyan on 12/4/19.
//  Copyright © 2019 Tigran Sarkisyan. All rights reserved.
//

import UIKit
import CoreData
import SwiftyBeaver

class ViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private let weatherManager = WeatherDataManager()
    private var cityWeatherList = [CityWeather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentDate()
        setTableView()
        getWeatherData()
    }
    
    @IBAction func onSettingsClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "Settings not implemented yet!", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func setCurrentDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = AppConstants.Date.DATE_MMMM_D_FORMAT
        dateLabel.text =  formatter.string(from: Date())
    }
    
    private func setTableView() {
        tableView.register(
            UINib(nibName: WeatherTableViewCell.className, bundle: nil),
            forCellReuseIdentifier: Identifiers.Cells.TableView.WeatherCell
        )
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getWeatherData() {
        weatherManager.getCityCurrentWeatherAndImage(success: { currentTemp, weatherImageUrl in
            WeatherDatabaseManager.storeCurrentTemp(currentTemp: currentTemp)
            
            self.tempLabel.text = currentTemp
            ImageLoader.loadImage(
                imageView: self.weatherImage,
                url: weatherImageUrl,
                placeholder: "sun.png"
            )
        })
        
        weatherManager.getWeatherListPerHour (success: { weatherForecast in
            self.cityWeatherList = weatherForecast
            self.tableView.reloadData()
        }, failure: { error in
            let alert = UIAlertController(title: error.description, message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true)
        })
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityWeatherList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Identifiers.Cells.TableView.WeatherCell,
            for: indexPath) as! WeatherTableViewCell
        
        cell.setup(cityWeather: cityWeatherList[indexPath.row])
        
        return cell
    }
    
}

