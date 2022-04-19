// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "WeatherFeature",
            targets: ["WeatherFeature"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WeatherAPIClient",
            dependencies: [
                "SharedModel"
            ]),
        .target(
            name: "WeatherFeature",
            dependencies: [
                "SharedModel",
                "WeatherAPIClient"
            ]),
        .target(
            name: "SharedModel",
            dependencies: []),
    ]
)
