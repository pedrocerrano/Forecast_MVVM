//
//  NetworkingController.swift
//  Forecast_MVVM
//
//  Created by Karl Pfister on 2/13/22.
//

import Foundation

class NetworkingContoller {
    let baseURLString = "https://api.weatherbit.io"
    
    func fetchDays(completion: @escaping (Result<TopLevelDictionary, NetworkError>) -> Void) {
        guard let baseURL = URL(string: baseURLString) else {return}

        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/v2.0/forecast/daily"
        
        let apiQuery = URLQueryItem(name: "key", value: "8503276d5f49474f953722fa0a8e7ef8")
        let cityQuery = URLQueryItem(name: "city", value:"Salt Lake")
        let unitsQuery = URLQueryItem(name: "units", value: "I")
        urlComponents?.queryItems = [apiQuery,cityQuery,unitsQuery]
        
        guard let finalURL = urlComponents?.url else {return}
        print(finalURL)
  
        let request = URLRequest(url: finalURL)
        let service = APIService()
        
        service.perform(request) { result in
            switch result {
            case .success(let data):
                do {
                    let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                    completion(.success(topLevelDictionary))
                } catch {
                    print("Error in Do/Try/Catch: \(error.localizedDescription)")
                    completion(.failure(.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
}
