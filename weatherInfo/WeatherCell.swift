//
//  WeatherCell.swift
//  weatherInfo
//
//  Created by Macbook Pro on 1/21/2560 BE.
//  Copyright © 2560 Student. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    
    func ConfigureCell(forecast: Forecast){
        minTemp.text = forecast.minTemp
        maxTemp.text = forecast.maxTemp
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }
    
}
