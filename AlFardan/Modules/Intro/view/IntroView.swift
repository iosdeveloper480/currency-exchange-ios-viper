//
//  IntroView.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import UIKit

class IntroMainView: UIViewController {
    
    var presentor: ViewToPresenterProtocol?
    
    private var pageController: UIPageViewController?
    private var pages = [Pages]()/// = Pages.allCases
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentor?.startFetchingPages()
        self.view.backgroundColor = .white
    }
    
    private func setupPageController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        let initialVC = IntroPageView(with: pages[0])
        initialVC.delegate = self
        
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        
        self.pageController?.didMove(toParent: self)
    }
}
extension IntroMainView: PresenterToViewProtocol {
    func show(pages: Array<Pages>) {
        self.pages = pages
        self.setupPageController()
    }
}
extension IntroMainView: IntroMainViewProtocol {
    func didTapSkipButton() {
        self.presentor?.showLoginController(navigationController: navigationController!)
    }
    func didTapGetStartedButton() {
        
    }
}

extension IntroMainView: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? IntroPageView else {
            return nil
        }
        
        var index = currentVC.page.index
        
        if index == 0 {
            return nil
        }
        
        index -= 1
        
        let vc = IntroPageView(with: pages[index])
        vc.delegate = self
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? IntroPageView else {
            return nil
        }
        
        var index = currentVC.page.index
        
        if index >= self.pages.count - 1 {
            return nil
        }
        
        index += 1
        
        let vc = IntroPageView(with: pages[index])
        vc.delegate = self
        return vc
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}
