//
//  extension+spinner.swift
//  Stock
//
//  Created by Михаил Борисов on 06.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

var vSpinner: UIView?
var blurView: UIView?

public extension UIViewController {
    func showSpinner(onView: UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame =  CGRect(x: onView.center.x - 55, y: onView.center.y - 55, width: 110, height: 110)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 15
        blurEffectView.layer.masksToBounds = true
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(blurEffectView)
            onView.addSubview(spinnerView)
        }

        blurView = blurEffectView
        vSpinner = spinnerView
    }

    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            blurView?.removeFromSuperview()
            blurView = nil
            vSpinner = nil
        }
    }
}
