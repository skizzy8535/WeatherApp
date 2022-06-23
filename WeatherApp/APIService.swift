//
//  APIService.swift
//  WeatherApp
//
//  Created by 林祐辰 on 2022/5/24.
//

import Foundation



class APIService {
    
    static let shared = APIService()
    
    enum APIError:Error{
        case error(_ errorString:String)
    }
    
    func getJSON<T:Codable>(linkString:String,
                 dateDecodeStrategy:JSONDecoder.DateDecodingStrategy = .secondsSince1970,
                 keyDecodeStrategy:JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                 completion: @escaping (Result<T,APIError>)->Void){
        
        
        guard let jsonLink = URL(string: linkString) else {
            completion(.failure(.error(NSLocalizedString("Invalid URL", comment: ""))))
            return
            
        }
        
        URLSession.shared.dataTask(with: jsonLink) { data, response, error in

            if let error = error {
                completion(.failure(.error("Error : \(error.localizedDescription)")))
            }
            
            guard let data = data else {
                completion(.failure(.error(NSLocalizedString("Corrupted Data", comment: ""))))
                return
            }
            
            let jsDecoder = JSONDecoder()
            jsDecoder.dateDecodingStrategy = dateDecodeStrategy
            jsDecoder.keyDecodingStrategy = keyDecodeStrategy
            
            do {
                let successData = try jsDecoder.decode(T.self, from: data)
                completion(.success(successData))
            } catch let decodingError {
                completion(.failure(.error("Error: \(decodingError.localizedDescription)")))
            }
        }.resume()
        
        
    }
    
    
}
