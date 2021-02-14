//
//  MovieDetailViewModel.swift
//  Teknasyon-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

class MovieDetailViewModel: NSObject {
    
    // MARK: - Proporties
    
    private let dateFormat = "yyyy-MM-dd"
    private let newDateFormat = "dd.MM.yy"
    private let movieDetailEndPoint = "/movie/\(ObjectStore.shared.movieId ?? 0)"
    private var apiService: APIService!
    private var movieDetailResponse: ResultModel?
    private var error: String = ""
    
    var delegate: MovieDetailViewModelDelegate?
    
    // MARK: - Life Cycles
    
    override init() {
        super.init()
        self.apiService = APIService()
        self.getMovieDetailData()
    }
    
    // MARK: - Service Call Methods
    
    private func getMovieDetailData() {
        apiService.apiToGetData(isResult: false, endPoint: self.movieDetailEndPoint) { [weak self] _, error, responseModel in
            guard let self = self else { return }
            if var response = responseModel, error.isEmpty {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = self.dateFormat
                let releaseDate = dateFormatter.date(from: (response.releaseDate ?? "")) ?? Date()
                dateFormatter.dateFormat = self.newDateFormat
                let myString = dateFormatter.string(from: releaseDate)
                response.releaseDate = myString
                self.movieDetailResponse = response
                self.delegate?.updateView(movieDetailResponse: self.movieDetailResponse, errorText: self.error)
            }
            self.error = error
        }
    }
}

