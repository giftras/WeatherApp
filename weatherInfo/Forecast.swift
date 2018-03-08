//
//  Forecast.swift
//  weatherInfo
//
//  Created by Macbook Pro on 1/20/2560 BE.
//  Copyright © 2560 Student. All rights reserved.
//

import UIKit
import Alamofire
class Forecast{
    var _date : String!
    var _weatherType : String!
    var _minTemp : String!
    var _maxTemp : String!
    
    var date : String{
        if(_date == nil){
            _date = ""
        }
        return _date
        }
    
    var weatherType: String{
        if(_weatherType == nil){
            _weatherType = ""
        }
        return _weatherType
    }
    
    var minTemp: String{
        if(_minTemp == nil){
            _minTemp = ""
        }
        return _minTemp
    }
    
    var maxTemp: String{
        if(_maxTemp == nil){
            _maxTemp = ""
        }
        return _maxTemp
    }
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject>{
            if let min = temp["min"] as? Double{
                let kelvinToCelcius = Double(round(min-273.15))
                self._minTemp = String(kelvinToCelcius)
            }
            if let max = temp["max"] as? Double{
                let kelvinToCelcius = Double(round(max-273.15))
                self._maxTemp = String(kelvinToCelcius)
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            if let weatherType = weather[0]["main"] as? String{
                self._weatherType = weatherType
            }
        }
        
        if let date = weatherDict["dt"] as? Double{
            let unixDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            self._date = dateFormatter.string(from: unixDate)
        }

    }
    
}
