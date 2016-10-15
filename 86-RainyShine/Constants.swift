//
//  Constants.swift
//  86-RainyShine
//
//  Created by Brian Leip on 10/11/16.
//  Copyright © 2016 Triskelion Studios. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
var LATITUDE = "lat=\(Location.sharedInstance.latitude)"
var LONGITUDE = "&lon=\(Location.sharedInstance.longitude)"
//var LATITUDE = "lat=37.785834"
//var LONGITUDE = "&lon=-122.406417"
let APP_ID = "&appid="
let API_KEY = "3574f1c4a9c0a0e05bd3835b53574817"

var CURRENT_WEATHER_URL = BASE_URL + LATITUDE + LONGITUDE + APP_ID + API_KEY

var FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=3574f1c4a9c0a0e05bd3835b53574817"
//let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=46&lon=-132&cnt=10&mode=json&appid=3574f1c4a9c0a0e05bd3835b53574817"

typealias DownloadComplete = () -> ()

func UpdateURLs (latitude: Double, longitude: Double) {
    LATITUDE = "lat=\(latitude)"
    LONGITUDE = "&lon=\(longitude)"
    CURRENT_WEATHER_URL = BASE_URL + LATITUDE + LONGITUDE + APP_ID + API_KEY
    FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(latitude)&lon=\(longitude)&cnt=10&mode=json&appid=3574f1c4a9c0a0e05bd3835b53574817"
}


