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
    private var group: DispatchGroup!
    
    // MARK: - Life Cycles
    override init() {
        super.init()
        self.apiService = APIService.shared
        self.group = DispatchGroup()
        self.fetchData()
    }
    
    // MARK: - Service Call Methods
    private func fetchData() {
        
        self.group.enter()
        apiService.getRequest(path: self.nowPlayingEndPoint, class: ResponseModel.self) { [weak self] response, error in
            guard let self = self else { return }
            if error != nil {
                self.error = error.debugDescription
            } else {
                if let response = response {
                    self.nowPlayingResponse = response
                }
            }
            self.group.leave()
        }
        
        self.group.enter()
        apiService.getRequest(path: self.popularEndPoint, class: ResponseModel.self) { [weak self] response, error in
            guard let self = self else { return }
            if error != nil {
                self.error = error.debugDescription
            } else {
                if let response = response {
                    self.popularResponse = response
                }
            }
            self.group.leave()
        }
        
        group.notify(queue: .main) {
            self.delegate?.updateView(nowPlayingData: self.nowPlayingResponse,
                                      popularData: self.popularResponse,
                                      errorText: self.error)
        }
    }
}
