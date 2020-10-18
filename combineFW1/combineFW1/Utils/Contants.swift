//
//  Contants.swift
//  combineFW1
//
//  Created by Greg Hughes on 10/17/20.
//

import Foundation

struct Contants {
    struct URLs {
        
        static func weather(city:String) -> String{
            return "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=f3de58f44102809871379c2d37a64aa3&units=Imperial"
        }
        static let weather = "https://api.openweathermap.org/data/2.5/weather?q=Boston&appid=f3de58f44102809871379c2d37a64aa3&units=Imperial"
    }
}
