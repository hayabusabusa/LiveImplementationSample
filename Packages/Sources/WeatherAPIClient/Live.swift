//
//  Live.swift
//  
//
//  Created by Shunya Yamada on 2022/04/19.
//

import Combine
import Foundation
import SharedModel

public extension WeatherAPIClient {
    static let live = Self.init(
        weather: {
            URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.metaweather.com/api/location/1117817")!)
                .map { $0.data }
                .decode(type: WeatherResponse.self, decoder: weatherJSONDecoder)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        },
        search: { coordinate in
            URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.metaweather.com/api/location/search/?lattlong=\(coordinate.latitude),\(coordinate.longitude)")!)
                .map { $0.data }
                .decode(type: [LocationSearchResponse].self, decoder: weatherJSONDecoder)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    )
}

private let weatherJSONDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    jsonDecoder.dateDecodingStrategy = .formatted(formatter)
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    return jsonDecoder
}()
