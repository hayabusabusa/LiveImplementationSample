//
//  WeatherViewModel.swift
//  
//
//  Created by Shunya Yamada on 2022/04/19.
//

import Combine
import Foundation
import SharedModel
import WeatherAPIClient

public final class WeatherViewModel {

    private let apiClient: WeatherAPIClient
    private var cancellables = Set<AnyCancellable>()

    private let consolidatedWeathersSubject = CurrentValueSubject<[WeatherResponse.ConsolidatedWeather], Never>([])

    var consolidatedWeathersPublisher: AnyPublisher<[WeatherResponse.ConsolidatedWeather], Never> {
        return consolidatedWeathersSubject.eraseToAnyPublisher()
    }

    public init(apiClient: WeatherAPIClient = .live) {
        self.apiClient = apiClient
    }

    func onViewDidLoad() {
        apiClient.weather()
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            } receiveValue: { [weak self] response in
                self?.consolidatedWeathersSubject.send(response.consolidatedWeather)
            }
            .store(in: &cancellables)
    }
}
