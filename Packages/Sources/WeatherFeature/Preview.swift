//
//  Preview.swift
//  
//
//  Created by Shunya Yamada on 2022/04/20.
//

import SwiftUI
import UIKit
import WeatherAPIClient

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
        WeatherViewController.Wrapped()
    }
}
