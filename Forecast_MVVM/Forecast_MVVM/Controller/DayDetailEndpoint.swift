//
//  DayDetailEndpoint.swift
//  Forecast_MVVM
//
//  Created by iMac Pro on 3/9/23.
//

import Foundation

enum DayDetailEndpoint {
    static let baseURL = URL(string: "https://api.weatherbit.io")
    
    case dayDetail
    
    var fullURL: URL? {
        guard let url = Self.baseURL,
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        
        switch self {
        case .dayDetail:
            urlComponents.path.append("/v2.0/forecast/daily")
        }
        
        let apiQuery = URLQueryItem(name: "key", value: "8503276d5f49474f953722fa0a8e7ef8")
        let cityQuery = URLQueryItem(name: "city", value:"Salt Lake")
        let unitsQuery = URLQueryItem(name: "units", value: "I")
        urlComponents.queryItems = [apiQuery, cityQuery, unitsQuery]
        
        return urlComponents.url
    }
}




