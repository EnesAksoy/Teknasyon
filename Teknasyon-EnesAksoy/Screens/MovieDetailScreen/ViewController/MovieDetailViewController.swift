//
//  MovieDetailViewController.swift
//  Teknasyon-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    // MARK: - Constants
    
    private let errorKey = "MessageTitle1"
    private let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    private let placeholderText = "placeholder"

    // MARK: - Outlets
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    // MARK: - Proporties
    
    private var viewModel: MovieDetailViewModel!
    private var movieDetailResponse: ResultModel?
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            LoadingView.showLoadingView()
        }
        self.viewModel = MovieDetailViewModel()
        self.viewModel.delegate = self
    }
    
    // MARK: - Functions
    
    private func updateView() {
        self.posterImage.kf.indicatorType = .activity
        let urlPoster = URL(string: "\(self.imageBaseUrl)\(self.movieDetailResponse?.backdropPath ?? "")")
        self.posterImage.kf.setImage(with: urlPoster, placeholder: UIImage(named: self.placeholderText))
        self.movieTitle.text = self.movieDetailResponse?.title
        self.movieDescription.text = self.movieDetailResponse?.overview
        self.starCountLabel.text = "\(self.movieDetailResponse?.starCount ?? 0)"
        self.dateLabel.text = self.movieDetailResponse?.releaseDate
    }
}

// MARK: - Movie Detail View Model Delegate

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func updateView(movieDetailResponse: ResultModel?, errorText: String) {
        LoadingView.removeLoadingView()
        if !errorText.isEmpty {
            self.createAlert(message: errorText, title: self.localizableGetString(forkey: self.errorKey))
        }else {
            self.movieDetailResponse = movieDetailResponse
            self.updateView()
        }
    }
}
