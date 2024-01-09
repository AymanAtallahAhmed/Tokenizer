//
//  TokenizeEngineProtocol.swift
//  Tokenizer
//
//  Created by Attaallah Ayman, Vodafone on 09/01/2024.
//

import Foundation

protocol TokenizeEngineProtocol{
    /// Tokenizes the given text depending on the passed language and it's tokens.
    /// - Parameters:
    ///   - text: Text that will be tokenized.
    ///   - language: Language that contains it's needed tokens.
    /// - Returns: A *NSMutableAttributedString* array of the generated sentences.
    func tokenize(text: String, language: Language) -> [NSMutableAttributedString]
}
