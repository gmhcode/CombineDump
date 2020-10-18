//
//  WebService.swift
//  combineFW1
//
//  Created by Greg Hughes on 10/17/20.
//

import Foundation
import Combine
class WebService {
    func fetchWeather(city: String)-> AnyPublisher<Weather,Error> {
        guard let url = URL(string: Contants.URLs.weather(city: city)) else { fatalError("invalid URL")}
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: WeatherRespose.self, decoder: JSONDecoder())
            .map{$0.main}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
