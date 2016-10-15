//
//  WeatherCell.swift
//  86-RainyShine
//
//  Created by Brian Leip on 10/14/16.
//  Copyright © 2016 Triskelion Studios. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
    func configureCell(forecast: Forecast) {
        lowTemp.text = String(forecast.lowTemp)
        highTemp.text = String(forecast.highTemp)
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }

}
