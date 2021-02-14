//
//  ResponseModel.swift
//  Teknasyon-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

struct ResponseModel: Codable {
    var results: [ResultModel]
    let totalPages: Int?
    
    private enum CodingKeyss: String, CodingKey {
        case totalPages = "total_pages"
    }
}
