//
//  ViewController.swift
//  ParallaxImage
//
//  Created by Vadim Rufov on 19.9.2023.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    private let imageHeight = 270.0
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "image.png")
        view.contentMode = .scaleToFill
        return view
    }()
    
    var imageViewTopAnchor: NSLayoutConstraint!
    var imageViewHeightAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.bounds.height * 2)
        imageViewTopAnchor = imageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        imageViewHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: imageHeight)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageViewTopAnchor,
            imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            imageView.widthAnchor.constraint(equalToConstant: scrollView.contentSize.width),
            imageViewHeightAnchor,
        ])
        
        scrollView.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetheight = scrollView.contentOffset.y
        
        if contentOffsetheight < 0 {
            imageViewTopAnchor.constant = contentOffsetheight
            imageViewHeightAnchor.constant = imageHeight - contentOffsetheight
        }
        
        scrollView.verticalScrollIndicatorInsets.top = imageViewHeightAnchor.constant - view.safeAreaInsets.top
    }
    
}
