//
//  NetworkingService.swift
//  Forecast_MVVM
//
//  Created by Karl Pfister on 2/13/22.
//

import Foundation

class NetworkingService {
    
    func fetchDays(with endpoint: DayDetailEndpoint, completion: @escaping (Result<TopLevelDictionary, NetworkError>) -> Void) {
        guard let finalURL = endpoint.fullURL else {return}
  
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
