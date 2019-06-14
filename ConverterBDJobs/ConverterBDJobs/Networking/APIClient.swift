//
//  APIClient.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/15/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import Foundation

class APIClient {
    
    enum Endpoints {
        static let base = "https://jsonvat.com/"
        
        case getWatchlist
        
        var stringValue: String {
            switch self {
            case .getWatchlist: return Endpoints.base
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                
            }
        }
        task.resume()
        
        return task
    }
    
    
    class func getWatchlist(completion: @escaping ([Rate], Error?) -> Void) {
        _ = taskForGETRequest(url: Endpoints.getWatchlist.url, responseType: Tax.self) { response, error in
            
            if let response = response {
                completion(response.rates, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    
}
