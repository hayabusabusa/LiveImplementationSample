//
//  Interface.swift
//  
//
//  Created by Shunya Yamada on 2022/04/19.
//

import Combine
import CoreLocation
import Foundation
import SharedModel

public struct WeatherAPIClient {
    public var weather: () -> AnyPublisher<WeatherResponse, Error>
    public var search: (CLLocationCoordinate2D) -> AnyPublisher<[LocationSearchResponse], Error>

    public init(
        weather: @escaping () -> AnyPublisher<WeatherResponse, Error>,
        search: @escaping (CLLocationCoordinate2D) -> AnyPublisher<[LocationSearchResponse], Error>
    ) {
        self.weather = weather
        self.search = search
    }
}
