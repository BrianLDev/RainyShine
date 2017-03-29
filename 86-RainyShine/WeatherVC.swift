//
//  WeatherVC.swift
//  86-RainyShine
//
//  Created by Brian Leip on 10/11/16.
//  Copyright © 2016 Triskelion Studios. All rights reserved.
//

import UIKit
import CoreLocation // allows you to get the device's current location
import Alamofire    // CocoaPod

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts: [Forecast] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("***viewDidLoad() CONSOLE OUTPUT***")
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

        tableView.delegate = self
        tableView.dataSource = self
        
        print(CURRENT_WEATHER_URL)
        currentWeather = CurrentWeather()
        forecasts = [Forecast]()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            if (locationManager.location?.coordinate.longitude != nil) {
                // make sure that locationManager has some data to work with first

                currentLocation = locationManager.location
                Location.sharedInstance.latitude = currentLocation.coordinate.latitude
                Location.sharedInstance.longitude = currentLocation.coordinate.longitude
                UpdateURLs(latitude: Location.sharedInstance.latitude, longitude: Location.sharedInstance.longitude)
                
                print("\n***locationAuthStatus() CONSOLE OUTPUT***")
                print(Location.sharedInstance.latitude)
                print(Location.sharedInstance.longitude)
                print(LATITUDE)
                print(LONGITUDE)
                print(CURRENT_WEATHER_URL)
                print(FORECAST_URL)
                
                currentWeather.downloadWeatherDetails {
                    self.downloadForecastData {
                        self.updateMainUI()
                    }
                }
            } else {
                // if locationManager doesn't have any data to work with, call locationAuthStatus again
                locationAuthStatus()
            }
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //downloading forecast weather data for TableView
        Alamofire.request(FORECAST_URL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        //print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        temperatureLabel.text = String(currentWeather.currentTemp)
        print("\n***updateMainUI() CONSOLE OUTPUT***")
        print(temperatureLabel.text!)
        print(String(currentWeather.currentTemp))
        weatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        weatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }


}

