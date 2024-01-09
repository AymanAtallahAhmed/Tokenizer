//
//  TokenizeEngineMock.swift
//  TokenizerTests
//
//  Created by Attaallah Ayman, Vodafone on 09/01/2024.
//

import Foundation
@testable import Tokenizer

class TokenizeEngineMock: TokenizeEngineProtocol {
    func tokenize(text: String, language: Language) -> [NSMutableAttributedString] {
        let mockText = NSMutableAttributedString(string: text)
        return [mockText]
    }
}
