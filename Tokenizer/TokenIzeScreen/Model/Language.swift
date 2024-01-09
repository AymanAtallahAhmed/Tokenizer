//
//  Language.swift
//  Tokenizer
//
//  Created by Attaallah Ayman, Vodafone on 08/01/2024.
//

import Foundation

enum Language {
    case En(name: String, words: [String])
    case Sp(name: String, words: [String])

    func name() -> String {
        switch self {
        case .En(name: let name, words: _):
            return name
        case .Sp(name: let name, words: _):
            return name
        }
    }

    func words() -> [String] {
        switch self {
        case .En(name: _, words: let words):
            return words
        case .Sp(name: _, words: let words):
            return words
        }
    }
}
