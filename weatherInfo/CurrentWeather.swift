//
//  CurrentWeather.swift
//  weatherInfo
//
//  Created by Macbook Pro on 1/17/2560 BE.
//  Copyright © 2560 Student. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather{
    var _cityName : String!
    var _date : String!
    var _weatherType : String!
    var _currentTemp : String!
    
    var cityName: String{
        if(_cityName == nil){
            _cityName = ""
        }
        return _cityName
    }
    var date: String{
        if(_date == nil){
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today \(currentDate)"
        
        
        return _date
    }
    var weatherType: String{
        if(_weatherType == nil){
            _weatherType = ""
        }
        return _weatherType
    }
    var currentTemp: String{
        if(_currentTemp == nil){
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping () -> () ){
        
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject >{
                if let name = dict["name"] as? String{
                    self._cityName = name.uppercased()
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject >{
                    if let currentTemparature = main["temp"] as? Double{
                        let kelvinToCelcius = Double(round(currentTemparature-273.15))
                    self._currentTemp = String(kelvinToCelcius)
                    }
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let weatherType = weather[0]["main"] as? String{
                       self._weatherType = weatherType
                    }
                }

            }
            
            completed()
            
        }
        
    }

    
    
}
