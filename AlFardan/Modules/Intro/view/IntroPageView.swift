//
//  IntroPageView.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

class IntroPageView: UIViewController {
    
    private var titleLabel: UILabel?
    private var imageView: UIImageView?
    private var skipButton: UIButton?
    
    weak var delegate: IntroMainViewProtocol?
    
    var page: Pages
    
    init(with page: Pages) {
        self.page = page
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTitleLabel()
        self.setupImage()
        self.setupSkipButton()
    }
}

extension IntroPageView {
    private func setupTitleLabel() {
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.center = CGPoint(x: 160, y: 250)
        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.text = page.name
        self.view.addSubview(titleLabel!)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.titleLabel!, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.titleLabel!, attribute: .centerX, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1, constant: 0)
        ])
    }
    private func setupImage() {
        self.imageView = UIImageView()
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.contentMode = .scaleAspectFit
        
        self.imageView?.image = UIImage(named: page.image)
        
        self.view.addSubview(self.imageView!)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.imageView!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: self.imageView!, attribute: .bottom, relatedBy: .equal, toItem: self.titleLabel!, attribute: .bottom, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: self.imageView!, attribute: .centerX, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.imageView!, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.imageView!, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: 0),
        ])
    }
    
    private func setupSkipButton() {
        self.skipButton = UIButton()
        self.skipButton?.translatesAutoresizingMaskIntoConstraints = false
        self.skipButton?.setTitleColor(.blue, for: .normal)
        self.skipButton?.setTitle("Skip", for: .normal)
        self.skipButton?.addTarget(self, action: #selector(self.didTapSkipButton), for: .touchUpInside)
        
        self.view.addSubview(self.skipButton!)
        self.skipButton?.isHidden = true
        if page.index == 3 {
            self.skipButton?.isHidden = false
        }
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.skipButton!, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: self.skipButton!, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0),
        ])
    }
}

extension IntroPageView {
    @objc private func didTapSkipButton() {
        self.delegate?.didTapSkipButton()
    }
    @objc private func didTapGetStartedButton() {
        self.delegate?.didTapGetStartedButton()
    }
}
