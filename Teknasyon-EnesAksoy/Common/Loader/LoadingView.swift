//
//  LoadingView.swift
//  Teknasyon-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import UIKit

class LoadingView {
    
    // MARK: - Show Loading Method
    static func showLoadingView() {
        removeLoadingView()
        let mainView = UIView(frame: UIScreen.main.bounds)
        mainView.backgroundColor = .clear
        let darkView = UIView(frame: mainView.frame)
        darkView.backgroundColor = UIColor.black
        darkView.alpha = 0.7
        mainView.addSubview(darkView)
        let spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(spinnerView)
        spinnerView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        spinnerView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        spinnerView.startAnimating()
        mainView.tag = 1991
        DispatchQueue.main.async {
            (UIApplication.shared.delegate as? AppDelegate)?.window?.addSubview(mainView)
        }
    }
    
    // MARK: - Remove Loading Method
    static func removeLoadingView() {
        DispatchQueue.main.async {
            (UIApplication.shared.delegate as? AppDelegate)?.window?.viewWithTag(1991)?.removeFromSuperview()
        }
    }
}
