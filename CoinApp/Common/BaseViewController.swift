//
//  BaseViewController.swift
//  CoinApp
//
//  Created by Angie Mugo on 13/01/2025.
//

import UIKit
import SwiftUI

class BaseViewController: UIViewController {
    private var genericErrorView: UIView?
    private var loadingView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showErrorView(error: CoinAppClientError) {
        if genericErrorView == nil {
            let errorView = ErrorView(error: error)
            let errorVC = AddSwiftUIView(errorView)
            genericErrorView = errorVC.view
        }
    }

    func removeErrorView() {
        if genericErrorView != nil && view.subviews.contains(genericErrorView!) {
            genericErrorView?.removeFromSuperview()
        }
    }

    func showLoadingView() {
        if loadingView == nil {
            let loadingView = LoadingView()
            let loadingVC = AddSwiftUIView(loadingView)

            self.loadingView = loadingVC.view
        }
    }

    func hideLoading() {
        if loadingView != nil && view.subviews.contains(loadingView!) {
            loadingView?.removeFromSuperview()
        }
    }
}


