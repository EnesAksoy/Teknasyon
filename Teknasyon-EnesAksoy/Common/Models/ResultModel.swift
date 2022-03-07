//
//  ResultModel.swift
//  Teknasyon-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

struct ResultModel: Codable {
    let title: String?
    let overview: String?
    let id: Int?
    let backdropPath: String?
    let posterPath: String?
    var releaseDate: String?
    let starCount: Double?
    let imdbId: String?
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case overview
        case id
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case starCount = "vote_average"
        case imdbId = "imdb_id"
        case name
    }
}
