//
//  Preview.swift
//  
//
//  Created by Shunya Yamada on 2022/04/20.
//

import SwiftUI
import UIKit
import SharedModel
import WeatherAPIClient

private extension WeatherCollectionViewCell {

    struct Wrapped: UIViewRepresentable {
        typealias UIViewType = WeatherCollectionViewCell

        let consolidatedWeather: WeatherResponse.ConsolidatedWeather

        func updateUIView(_ uiView: WeatherCollectionViewCell, context: Context) {

        }

        func makeUIView(context: Context) -> WeatherCollectionViewCell {
            let cell = WeatherCollectionViewCell()
            cell.configure(with: consolidatedWeather)
            return cell
        }
    }
}

private extension WeatherViewController {

    struct Wrapped: UIViewControllerRepresentable {
        typealias UIViewControllerType = WeatherViewController

        func updateUIViewController(_ uiViewController: WeatherViewController, context: Context) {

        }

        func makeUIViewController(context: Context) -> WeatherViewController {
            let viewModel = WeatherViewModel(apiClient: .mock)
            let vc = WeatherViewController(viewModel: viewModel)
            return vc
        }
    }
}

struct WeatherViewController__Preview: PreviewProvider {

    static var previews: some View {
        Group {
            WeatherCollectionViewCell.Wrapped(
                consolidatedWeather: .init(
                    applicableDate: Date(),
                    id: 1,
                    maxTemp: 10,
                    minTemp: 20,
                    theTemp: 30,
                    weatherStateAbbr: .clear
                )
            )
                .previewLayout(.fixed(width: 320, height: 80))

            WeatherViewController.Wrapped()
        }
    }
}
