//
//  SplashScreenViewModelDelegate.swift
//  Teknasyon-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

protocol SplashScreenViewModelDelegate: AnyObject {
    func updateView(nowPlayingData: ResponseModel?, popularData: ResponseModel?, errorText: String)
}
