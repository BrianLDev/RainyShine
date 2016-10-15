//
//  CurrentWeather.swift
//  86-RainyShine
//
//  Created by Brian Leip on 10/11/16.
//  Copyright © 2016 Triskelion Studios. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //Alamofre download
        print("\n***downloadWeatherDetails() CONSOLE OUTPUT***")

        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        
        Alamofire.request(currentWeatherURL).responseJSON { response in
            print("\n***Alamofire.request() CONSOLE OUTPUT***")
            //let result = response.result
            //print(result)
            switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
            }
            
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self.cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print(self.weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemp = main["temp"] as? Double {

                        //let fahrenheitTemp = Double(round( (currentTemp * 9/5) - 459.67 ))
                        //let fahrenheitTemp = CurrentWeather.KelvinToFahrenheit(kelvinTemp: currentTemp)
                        self._currentTemp = CurrentWeather.KelvinToFahrenheit(kelvinTemp: currentTemp)
                        print(self.currentTemp)
                    }
                }
            }
            completed()
        }
        //completed()
    }
    
    
    static func KelvinToFahrenheit(kelvinTemp: Double) -> Double {
        //convert from Kelvin to Fahrenheit  ... ignored his math and made my own
        //  let kelvinToFahrenheitPreDivision = (currentTemperature * 9/5) - 459.67
        //  let kelvinToFahrenheit = Double(round(10 * kelvinToFahrenheit/10))        
        
        var fahrenheitTemp = (kelvinTemp * 9/5) - 459.67
        fahrenheitTemp = Double(round(fahrenheitTemp))
        return fahrenheitTemp
    }

    
}
    

