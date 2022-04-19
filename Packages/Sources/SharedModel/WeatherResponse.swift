//
//  WeatherResponse.swift
//  
//
//  Created by Shunya Yamada on 2022/04/19.
//

import Foundation

public struct WeatherResponse: Decodable, Equatable {
    public let consolidatedWeather: [ConsolidatedWeather]

    public init(consolidatedWeather: [WeatherResponse.ConsolidatedWeather]) {
        self.consolidatedWeather = consolidatedWeather
    }
}

public extension WeatherResponse {
    struct ConsolidatedWeather: Decodable, Equatable {
        public let applicableDate: Date
        public let id: Int
        public let maxTemp: Double
        public let minTemp: Double
        public let theTemp: Double
        public let weatherStateAbbr: WeatherStateAbbr?

        public init(
            applicableDate: Date,
            id: Int,
            maxTemp: Double,
            minTemp: Double,
            theTemp: Double,
            weatherStateAbbr: WeatherResponse.ConsolidatedWeather.WeatherStateAbbr?
        ) {
            self.applicableDate = applicableDate
            self.id = id
            self.maxTemp = maxTemp
            self.minTemp = minTemp
            self.theTemp = theTemp
            self.weatherStateAbbr = weatherStateAbbr
        }
    }
}

public extension WeatherResponse.ConsolidatedWeather {
    enum WeatherStateAbbr: String, Decodable {
        case snow = "sn"
        case sleet = "sl"
        case hail = "h"
        case thunderstorm = "t"
        case heavyRain = "hr"
        case lightRain = "lr"
        case showers = "s"
        case heavyCloud = "hc"
        case lightCloud = "lc"
        case clear = "c"
    }
}
