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
private var emptyView: UIView?

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

    func showEmpty() {
        if emptyView == nil {
            let emptyView = EmptyView()
            let emptyVC = AddSwiftUIView(emptyView)
            self.emptyView = emptyVC.view
        }

    }

    func hideEmpty() {
        if emptyView != nil && view.subviews.contains(emptyView!) {
            emptyView?.removeFromSuperview()
        }
    }
}
