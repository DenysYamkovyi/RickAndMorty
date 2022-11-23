//
//  NetworkService.swift
//  RMApp
//
//  Created by macbook pro on 2022-11-21.
//

import Foundation

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

enum Result<T> {
    case success(T)
    case failure(APIError)
}

/**
 Types of network errors
 ### Properties
 - **InvalidURL**.
 - **JSONDecodingError**
 - **RequestError**
 - **UnknownError**
 */
enum NetworkHandlerError: Error {
    case InvalidURL
    case JSONDecodingError
    case RequestError(String)
    case UnknownError
}

struct ResponseErrorMessage: Codable {
    let error: String
}

enum APIError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
    case badURL(String)
}

enum Endpoint: String {
    case characters = "character/"
    case details = ""
}

public struct NetworkService {
    
    var baseURL: String = "https://rickandmortyapi.com/api/"
    
    func dataRequest<T: Decodable>(with url: Endpoint, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
        
        guard let dataURL = URL(string: baseURL+url.rawValue) else {
            completion(.failure(APIError.badURL(url.rawValue)))
           return
        }
        
        let session = URLSession.shared
       
        let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
       
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                completion(Result.failure(APIError.networkError(error!)))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(APIError.dataNotFound))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(Result.success(decodedObject))
            } catch let error {
                completion(Result.failure(APIError.jsonParsingError(error as! DecodingError)))
            }
        })
        
        task.resume()
    }
    
    func decodeJSONData<T: Codable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkHandlerError.JSONDecodingError
        }
    }
}
