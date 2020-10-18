//
//  WeatherModel.swift
//  combineFW1
//
//  Created by Greg Hughes on 10/17/20.
//

import Foundation

struct WeatherRespose: Decodable {
    let main: Weather
}

struct Weather : Decodable {
    let temp: Double?
    let humidity: Double?
    
    static var placeholder: Weather {
        return Weather(temp: nil, humidity: nil)
    }
}
