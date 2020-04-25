//
//  APIClient.swift
//  Brocade
//
//  Created by Ryan Cohen on 3/31/20.
//

import Foundation

class APIClient {
    
    // MARK: - Attributes -
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    enum Endpoint: CustomStringConvertible {
        case base
        case items
        case getItem(String)
        
        var description: String {
            switch self {
            case .base:
                return "https://www.brocade.io/api"
            case .items:
                return "\(Endpoint.base)/items"
            case .getItem(let code):
                return "\(Endpoint.items)/\(code)"
            }
        }
    }
    
    // MARK: - Functions -
    
    func request<T: Codable>(_ method: HTTPMethod, endpoint: Endpoint, query: String? = nil, completion: @escaping (_ object: T?, _ error: Error?) -> Void) {
        var urlString: String = endpoint.description
        if let query = query {
            urlString.append("?query=")
            urlString.append(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil, nil)
            return
        }
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(object, error)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
