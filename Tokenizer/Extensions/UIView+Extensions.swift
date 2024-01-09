//
//  UIView+Extensions.swift
//  Tokenizer
//
//  Created by Attaallah Ayman, Vodafone on 08/01/2024.
//

import UIKit

public extension UIView {
    func setCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
