//
//  TokenizerViewModelProtocol.swift
//  Tokenizer
//
//  Created by Attaallah Ayman, Vodafone on 09/01/2024.
//

import Foundation

/// Protocol that defines the needed data from any tokenizer viewModel.
protocol TokenizerViewModelProtocol{
    /// Tokenize engine that will perform tokenization.
    var tokenizeEngine: TokenizeEngineProtocol { get }
    /// Languages that will be sent to the user.
    var languages: [Language] { get set }
    /// Sentences generated after tokenization
    var sentences: [NSMutableAttributedString] { get set }
    /// Tells the viewModel that the parent view's *viewDidLoad* method is invoked, it's needed to perform any needed logic.
    func viewDidLoad()
    /// Tokenize the given text then populate the generated sentences through sentences property.
    /// - Parameters:
    ///   - text: Text that will be tokenized.
    ///   - language: Language and it's wrapped tokens.
    /// - Note: The sentence property is a published property and needed to be listen to it's changes.
    func tokenize(text: String, for language: Language)
}
