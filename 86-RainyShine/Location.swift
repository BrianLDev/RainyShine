//
//  Location.swift
//  86-RainyShine
//
//  Created by Brian Leip on 10/14/16.
//  Copyright © 2016 Triskelion Studios. All rights reserved.
//

import Foundation
import CoreLocation //


class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
