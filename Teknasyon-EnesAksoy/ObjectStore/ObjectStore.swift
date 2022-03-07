//
//  ObjectStore.swift
//  Teknasyon-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

class ObjectStore {
    
    static let shared = ObjectStore()
    
    var nowPlayingData: ResponseModel?
    var popularData: ResponseModel?
    var movieId: Int?
    var imdbId: String?
}
