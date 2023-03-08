//
//  DayDetailViewModel.swift
//  Forecast_MVVM
//
//  Created by iMac Pro on 3/8/23.
//

import Foundation

protocol DayDetailViewDelegate: AnyObject {
    func updateUI()
}

class DayDetailViewModel {
    
    var forecastData: TopLevelDictionary?
    var days: [Day] {
        return forecastData?.days ?? []
    }
    private weak var delegate: DayDetailViewDelegate?
    private let networkingController: NetworkingContoller
    
    init(delegate: DayDetailViewDelegate, networkingController: NetworkingContoller = NetworkingContoller()) {
        self.delegate = delegate
        self.networkingController = networkingController
        self.fetchForecastData()
    }
    
    private func fetchForecastData() {
        NetworkingContoller.fetchDays { result in
            switch result {
            case .success(let forecastData):
                self.forecastData = forecastData
                self.delegate?.updateUI()
            case .failure(let error):
                print(error)
            }
        }
    }
}
