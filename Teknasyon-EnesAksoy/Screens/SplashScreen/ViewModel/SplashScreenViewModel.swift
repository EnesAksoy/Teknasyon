//
//  SplashScreenViewModel.swift
//  Teknasyon-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

class SplashScreenViewModel: NSObject {
    
    // MARK: - Constans
    
    private let nowPlayingEndPoint = "/movie/now_playing"
    private let popularEndPoint = "/tv/popular"
    
    // MARK: - Delegate
    
    var delegate: SplashScreenViewModelDelegate?
    
    // MARK: - Properties
    
    private var apiService: APIService!
    private var nowPlayingResponse: ResponseModel?
    private var popularResponse: ResponseModel?
    private var error: String = ""
    
    // MARK: - Life Cycles
    
    override init() {
        super.init()
        self.apiService = APIService()
        self.getNowPlayingData()
    }
    
    // MARK: - Service Call Methods
    
    private func getNowPlayingData() {
        apiService.apiToGetData(endPoint: self.nowPlayingEndPoint) { [weak self] responseModel, error, _  in
            guard let self = self else { return }
            if let response = responseModel, error.isEmpty {
                self.nowPlayingResponse = response
                self.getPopularData()
                return
            }
            self.error = error
        }
    }
    
    private func getPopularData() {
        apiService.apiToGetData(endPoint: self.popularEndPoint) { [weak self] responseModel, error, _ in
            guard let self = self else { return }
            if let response = responseModel, error.isEmpty {
                self.popularResponse = response
            }
            self.error = error
            self.delegate?.updateView(nowPlayingData: self.nowPlayingResponse,
                                      popularData: self.popularResponse,
                                      errorText: self.error)
        }
    }
}


