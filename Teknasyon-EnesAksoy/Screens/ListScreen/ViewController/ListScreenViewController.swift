//
//  ListScreenViewController.swift
//  Teknasyon-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import UIKit
import Kingfisher

class ListScreenViewController: UIViewController {
    
    // MARK: - Constans
    private let errorKey = "MessageTitle1"
    private let listTableViewCellId = "ListTableViewCell"
    private let sliderViewNibName = "SliderView"
    private let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    private let zeroInt = 0
    private let zeroCGFloat: CGFloat = 0
    
    // MARK: - Outlests
    @IBOutlet private weak var subSliderView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private var viewModel: ListScreenViewModel!
    private var nowPlayingData: ResponseModel?
    private var popularData: ResponseModel?
    private var newString: String = ""
    private var slides = [SliderView]()
    private var page: Int = 1

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewModel()
        self.getObjectStoreData()
        self.scrollView.delegate = self
        self.pageControllerConfiguration()
        self.setupSlider()
        self.tableViewConfiguration()
        self.tableView.reloadData()
    }
}

// MARK: - ScrollView Delegate
extension ListScreenViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
            pageControl.currentPage = Int(pageIndex)
            if scrollView.contentOffset.y != 0 {
                scrollView.contentOffset.y = 0
            }
        }
    }
}

// MARK: - UITableView Methods
extension ListScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.popularData?.results.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.listTableViewCellId,
                                                 for: indexPath) as! ListTableViewCell
        cell.configureCell(posterUrl: (self.popularData?.results[indexPath.row].posterPath ?? ""),
                           title: (self.popularData?.results[indexPath.row].name ?? ""),
                           starCount: "\(self.popularData?.results[indexPath.row].starCount ?? 0.0)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ObjectStore.shared.movieId = self.popularData?.results[indexPath.row].id
        let vc = MovieDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.popularData?.results.count ?? 0) - 10 {
            self.page += 1
            if page <= self.popularData?.totalPages ?? 500 {
                self.getPopularData(page: self.page)
            }
        }
    }
}

// MARK: - Helpers
private extension ListScreenViewController {
    
    func setupSlider() {
        self.slides = self.sliders()
        setSliderView(slides: self.slides)
    }
    
    func setupViewModel() {
        if viewModel == nil {
            self.viewModel = ListScreenViewModel()
        }
    }
    
    // Slider Page Create Method
    func sliders() -> [SliderView] {
        for i in 0...((self.nowPlayingData?.results.count)! - 1) {
            let slide: SliderView = Bundle.main.loadNibNamed(self.sliderViewNibName,
                                                             owner: self,
                                                             options: nil)?.first as! SliderView
            let imageUrl = URL(string: "\(self.imageBaseUrl)\(nowPlayingData?.results[i].backdropPath ?? "")")
            slide.descriptionLabel.text = nowPlayingData?.results[i].title
            slide.imageView.kf.indicatorType = .activity
            slide.imageView.kf.setImage(with: imageUrl)
            slides.append(slide)
        }
        return slides
    }
    
    // Get Object Store Data
    func getObjectStoreData() {
        self.viewModel.getObjectStoreData { nowPlayingData, popularData in
            self.nowPlayingData = nowPlayingData
            self.popularData = popularData
        }
    }
    
    // Get Popular Data
    func getPopularData(page: Int) {
        self.viewModel.getPopularData(page: page) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.createAlert(message: error, title: self.localizableGetString(forkey: self.errorKey))
            }else {
                self.getObjectStoreData()
                self.tableView.reloadData()
            }
        }
    }
    
    // Table View Configuration
    func tableViewConfiguration() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: self.listTableViewCellId, bundle: nil),
                                forCellReuseIdentifier: self.listTableViewCellId)
    }
    
    // Page Controller Configuration
    func pageControllerConfiguration() {
        self.pageControl.numberOfPages = (nowPlayingData?.results.count)!
        self.pageControl.currentPage = self.zeroInt
        self.pageControl.currentPageIndicatorTintColor = .white
        self.pageControl.pageIndicatorTintColor = .lightGray
    }
    
    // Set Slider View
    func setSliderView(slides: [SliderView]) {
        self.scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(slides.count), height: self.subSliderView.frame.height)
        for i in self.zeroInt ..< slides.count {
            slides[i].frame = CGRect(x: view.bounds.width * CGFloat(i),
                                     y: self.zeroCGFloat,
                                     width: scrollView.frame.width,
                                     height: self.subSliderView.frame.height)
            self.scrollView.addSubview(slides[i])
        }
    }
}
