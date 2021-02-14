//
//  MovieDetailViewModelDelegate.swift
//  Teknasyon-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelDelegate {
    func updateView(movieDetailResponse: ResultModel?, errorText: String)
}
