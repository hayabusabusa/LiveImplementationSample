//
//  Mock.swift
//  
//
//  Created by Shunya Yamada on 2022/04/19.
//

import Combine
import Foundation
import SharedModel

public extension WeatherAPIClient {
    static let empty = Self.init(
        weather: {
            Just(WeatherResponse(consolidatedWeather: []))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        },
        search: { _ in
            Just(WeatherResponse(consolidatedWeather: []))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    )

    static let successed = Self.init(
        weather: {
            Just(WeatherResponse(consolidatedWeather: [
                .init(
                    applicableDate: Date(),
                    id: 1,
                    maxTemp: 10,
                    minTemp: 20,
                    theTemp: 30,
                    weatherStateAbbr: .clear
                ),
                .init(
                    applicableDate: Date().addingTimeInterval(86400),
                    id: 2,
                    maxTemp: 20,
                    minTemp: 30,
                    theTemp: 10,
                    weatherStateAbbr: .thunderstorm
                )
            ]))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        },
        search: { _ in
            Just(WeatherResponse(consolidatedWeather: []))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    )

    static let failed = Self.init(
        weather: {
            Fail(error: NSError(domain: "", code: 1))
                .eraseToAnyPublisher()
        },
        search: { _ in
            Fail(error: NSError(domain: "", code: 1))
                .eraseToAnyPublisher()
        }
    )
}
