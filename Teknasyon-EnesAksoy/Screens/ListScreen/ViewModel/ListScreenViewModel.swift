//
//  ListScreenViewModel.swift
//  Teknasyon-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

class ListScreenViewModel: NSObject {
    
    // MARK: - Constans
       
    private let popularEndPoint = "/tv/popular"
    
    // MARK: - Properties
    
    private var apiService: APIService!
    
    // MARK: - Life Cycles
    
    override init() {
        super.init()
        self.apiService = APIService()
    }
    
    // MARK: - Get ObjectStore Data
    
    func getObjectStoreData(completion: @escaping(_ nowPlayingData: ResponseModel?, _ popularData: ResponseModel?) -> Void) {
        
        if let nowPlayingData = ObjectStore.shared.nowPlayingData, let popularData = ObjectStore.shared.popularData {
            completion(nowPlayingData, popularData)
        }
    }
    
    // MARK: - Get UpComing Data(Pagination)
    
    func getPopularData(page: Int,_ completion: @escaping() -> Void) {
        apiService.apiToGetData(page: page, endPoint: self.popularEndPoint) { [weak self] responseModel, error, _ in
            guard self != nil else { return }
            if let response = responseModel, error.isEmpty {
                ObjectStore.shared.popularData?.results.append(contentsOf: response.results)
                completion()
            }
        }
    }
    
}

