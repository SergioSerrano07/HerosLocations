//
//  NetworkModel.swift
//  AppleMaps
//
//  Created by sergio serrano on 13/9/22.
//

import Foundation

enum NetworkError: Error, Equatable {
    case malformedURL
    case dataFormatting
    case other
    case noData
    case errorCode(Int?)
    case decoding
    case tokenFormatError
}

final class NetworkModel {
    
    let session: URLSession
    
    var token: String?
    
    init(urlSession: URLSession = .shared,
         token: String? = nil) {
        session = urlSession
        self.token = token
        
    }
    
    func login(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
        guard let url = URL(string: "https://dragonball.keepcoding.education/api/auth/login") else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        let loginString = String(format: "%@:%@", user, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(nil, NetworkError.other)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(nil, NetworkError.errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let response = String(data: data, encoding: .utf8) else {
                completion(nil, NetworkError.decoding)
                return
            }
            
            self.token = response
            completion(response, nil)
        }
        
        task.resume()
    }
    
    func getHeroes(completion: @escaping ([HeroService], NetworkError?) -> Void) {
        
        let urlString = "https://dragonball.keepcoding.education/api/heros/all"
        
        struct Body: Encodable {
            let name: String
        }
        
        guard let token = token else {
            return
        }
        
        performAuthenticatedNetworkRequest(urlString,
                                           httpMethod: .post,
                                           httpBody: Body(name: ""),
                                           requestToken: token) { (result: Result<[HeroService], NetworkError>)  in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion([], failure)
            }
        }
    }
    
    func getLocalizationHero(for hero: HeroService, completion: @escaping ([HeroCordinates], NetworkError?) -> Void) {
        
        let urlString = "https://dragonball.keepcoding.education/api/heros/locations"
        
        struct Body: Encodable {
            let id: String
        }
        
        guard let token = token else {
            return
        }

        
        performAuthenticatedNetworkRequest(urlString,
                                           httpMethod: .post,
                                           httpBody: Body(id: hero.id),
                                           requestToken: token) { (result: Result<[HeroCordinates], NetworkError>)  in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion([], failure)
            }
        }
    }
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

private extension NetworkModel {
    func performAuthenticatedNetworkRequest<R: Decodable, B: Encodable>(_ urlString: String,
                                                                        httpMethod: HTTPMethod,
                                                                        httpBody: B?,
                                                                        requestToken: String,
                                                                        completion: @escaping (Result<R, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.malformedURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("Bearer \(requestToken)", forHTTPHeaderField: "Authorization")
        
        if let httpBody = httpBody {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try? JSONEncoder().encode(httpBody)
        }
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.other))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            guard let response = try? JSONDecoder().decode(R.self, from: data) else {
                completion(.failure(.decoding))
                return
            }
            completion(.success(response))
        }
        
        task.resume()
    }
}
