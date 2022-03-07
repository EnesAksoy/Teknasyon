//
//  APIService.swift
//  Teknasyon-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Typealias
typealias NetworkCompletionBlock<T> = ((T?, AFError?) -> Void)

class APIService: NSObject {
    
    static var shared = APIService()
    
    // MARK: - Constans
    private let baseUrlString = "https://api.themoviedb.org/3"
    private let apikey = "283d41c0628d9e3fa8d6b97935ca5220"
    private let resultModel: [ResultModel] = []
    
    // MARK: - Connect Api
    func getRequest<T: Codable>(path: String, httpMethod: HTTPMethod = .get, parameters: [String:Any]? = nil, class: T.Type, completion: @escaping(NetworkCompletionBlock<T>)) {
        let apiUrl = "\(baseUrlString)\(path)?api_key=\(apikey)"
        AF.request(apiUrl, method: httpMethod, parameters: parameters).responseDecodable { (response: DataResponse <T, AFError>) in
            switch response.result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
