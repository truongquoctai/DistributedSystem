//
//  WeatherModal.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 10/6/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import Foundation
import CoreLocation
struct LocationModal: Codable {
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    init(_ latitude: CLLocationDegrees,_ longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
struct WeatherModal: Codable {
    var id : Double
    var main: String
    var description: String
    var icon: String
    
    init(){
        self.id = 0
        self.main = ""
        self.description = ""
        self.icon = ""
    }
}

struct MainWeatherModal: Codable {
    var temp: Double
    var pressure: Double
    var humidity: Double
    var temp_min: Double
    var temp_max: Double
    
    init() {
        self.temp = 0
        self.pressure = 0
        self.humidity = 0
        self.temp_max = 0
        self.temp_min = 0
    }
    
    
}
struct DataWeatherModal: Codable {
    var main: MainWeatherModal
    var weather: WeatherModal
    init() {
        self.main = MainWeatherModal.init()
        self.weather = WeatherModal.init()
    }
}
