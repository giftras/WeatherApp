//
//  Constants.swift
//  weatherInfo
//
//  Created by Macbook Pro on 1/17/2560 BE.
//  Copyright © 2560 Student. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"

let APP_ID = "&appid="
let KEY = "52ad46444e3e8083d41d182a44c3a5de"

let CURRENT_WEATHER_URL = "\(BASE_URL)lat=\(Location.sharedInstance.lattitude!)&lon=\(Location.sharedInstance.longtitude!)\(APP_ID)\(KEY)"
let FORECAST_WEATHER_URL = "\(FORECAST_URL)lat=\(Location.sharedInstance.lattitude!)&lon=\(Location.sharedInstance.longtitude!)\(APP_ID)\(KEY)"

