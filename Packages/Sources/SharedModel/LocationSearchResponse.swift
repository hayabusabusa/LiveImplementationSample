//
//  LocationSearchResponse.swift
//  
//
//  Created by Shunya Yamada on 2022/04/20.
//

import Foundation

public struct LocationSearchResponse: Decodable, Equatable {
    public let distance: Int
    public let lattLong: String
    public let title: String
    public let woeid: String

    public init(
        distance: Int,
        latLong: String,
        title: String,
        woeid: String
    ) {
        self.distance = distance
        self.lattLong = latLong
        self.title = title
        self.woeid = woeid
    }
}
