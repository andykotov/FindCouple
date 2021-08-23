//
//  BunnerView.swift
//  FindCouple
//
//  Created by mr. Hakoda on 19.08.2021.
//

import GoogleMobileAds
import UIKit
import SwiftUI

struct BannerView: View{
    var body: some View{
        Banner().frame(width: 320, height: 50, alignment: .center)
    }
}


final private class Banner: UIViewControllerRepresentable  {

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)

        let viewController = UIViewController()
        view.adUnitID = "ca-app-pub-3940256099942544/2934735716" // Test banner ID
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
