//
//  WeatherVC.swift
//  weatherInfo
//
//  Created by Macbook Pro on 1/13/2560 BE.
//  Copyright © 2560 Student. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var currentTempLabel: UILabel!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
    
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    
    var currentWeather : CurrentWeather!
    var Forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.stopMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
        
    }
    
    func locationAuthStatus(){
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
            currentLocation = locationManager.location
            Location.sharedInstance.lattitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longtitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateUI()
                }
                
            }

            
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
        
    }
    
    func downloadForecastData(completed : @escaping () -> ())  {
        print(FORECAST_WEATHER_URL)
        Alamofire.request(FORECAST_WEATHER_URL).responseJSON { response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject >{
                print("dddddd")
                print(result.value)
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    for obj in list{
                        let forecast = Forecast(weatherDict: obj)
                        self.Forecasts.append(forecast)
                    }
                    
                }
                
                self.Forecasts.remove(at: 0)
                self.tableView.reloadData()
            }
                completed()
        }
        

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Forecasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{
            let forecast = Forecasts[indexPath.row]
            cell.ConfigureCell(forecast: forecast)
            return cell
        }else{
            return WeatherCell()
        }
        
    }
    
    func updateUI(){
        locationLabel.text = currentWeather.cityName
        currentTempLabel.text = currentWeather.currentTemp
        currentWeatherTypeLabel.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        dateLabel.text = currentWeather.date
    }
    
    
    
    

   }
