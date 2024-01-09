//
//  AttributedText+Extensions.swift
//  Tokenizer
//
//  Created by Attaallah Ayman, Vodafone on 09/01/2024.
//

import UIKit

public extension NSMutableAttributedString {
    func bold(_ value:String, size: CGFloat) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.boldSystemFont(ofSize: size)
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        self.append(NSAttributedString(" "))
        return self
    }

    func normal(_ value:String, size: CGFloat) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: size),
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        self.append(NSAttributedString(" "))
        return self
    }
}
