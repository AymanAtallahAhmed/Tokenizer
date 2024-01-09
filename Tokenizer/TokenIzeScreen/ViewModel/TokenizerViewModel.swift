//
//  TokenizerViewModel.swift
//  Tokenizer
//
//  Created by Attaallah Ayman, Vodafone on 09/01/2024.
//

import Foundation
import Combine

final class TokenizerViewModel: TokenizerViewModelProtocol {
    var tokenizeEngine: TokenizeEngineProtocol
    @Published var languages: [Language] = []
    @Published var sentences: [NSMutableAttributedString] = []

    init(tokenizeEngine: TokenizeEngineProtocol) {
        self.tokenizeEngine = tokenizeEngine
    }

    func viewDidLoad() {
        // These languages can be even fetched from the api then will be populated.
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
