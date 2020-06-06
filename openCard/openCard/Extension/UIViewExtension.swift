//
//  UIViewExtension.swift
//  openCard
//
//  Created by Joey Liu on 6/4/20.
//  Copyright © 2020 Joey Liu. All rights reserved.
//

import UIKit

extension UIView {
    func blink( duration: TimeInterval = 0.7, delay: TimeInterval = 0, alpha: CGFloat = 0) {
        UIView.animate(withDuration: duration, delay: delay, options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
            self.alpha = alpha
        }, completion: nil)
    }
    
    func openCardAnimation( duration: TimeInterval = 0.7, delay: TimeInterval = 0, alpha: CGFloat = 1, imageView: UIImageView?) {
        UIView.animate(withDuration: duration, delay: delay, options: [ .autoreverse, .curveEaseInOut], animations: {
            self.alpha = alpha
        }, completion: { finished in 
            self.alpha = 0
            guard let imageView = imageView else { return }
            imageView.startAnimating()
        })
    }
    
    
}
