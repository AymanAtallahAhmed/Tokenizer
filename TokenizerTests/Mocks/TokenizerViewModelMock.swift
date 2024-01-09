//
//  TokenizerViewModelMock.swift
//  TokenizerTests
//
//  Created by Attaallah Ayman, Vodafone on 09/01/2024.
//

import Foundation
@testable import Tokenizer

final class TokenizerViewModelMock {
    var tokenizeEngine: TokenizeEngineProtocol {
        TokenizeEngineMock()
    }

    @Published var languages: [Language] = []
    @Published var sentences: [NSMutableAttributedString] = []

    func viewDidLoad() {
        languages = [
            .En(name: "English", words: ["and", "if"]),
            .Sp(name: "Spanish", words: ["Si", "y"])
        ]
    }

    func tokenize(text: String, for language: Language) {
        let sentences = tokenizeEngine.tokenize(text: text, language: language)
        self.sentences = sentences
    }
}
