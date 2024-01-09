//
//  TokenizerTests.swift
//  TokenizerTests
//
//  Created by Attaallah Ayman, Vodafone on 08/01/2024.
//

import XCTest
@testable import Tokenizer

final class TokenizerViewModelTests: XCTestCase {
    var tokenizeEngineMock: TokenizeEngineMock!
    var viewModel: TokenizerViewModelProtocol!

    override func setUp() {
        tokenizeEngineMock = TokenizeEngineMock()
        viewModel = TokenizerViewModel(tokenizeEngine: tokenizeEngineMock)
    }

    override func tearDown() {
        tokenizeEngineMock = nil
        super.tearDown()
    }

    func testViewDidLoad() {
        // Before invoking viewDidLoad, languages should be empty
        XCTAssertTrue(viewModel.languages.isEmpty)

        viewModel.viewDidLoad()
        // After invoking viewDidLoad, languages should be populated
        XCTAssertFalse(viewModel.languages.isEmpty)
        XCTAssertEqual(viewModel.languages.count, 2)
        XCTAssertEqual(viewModel.languages[0].name(), "English")
        XCTAssertEqual(viewModel.languages[1].name(), "Spanish")
    }

    func testTokenizeEnglish() {
        viewModel.viewDidLoad()
        let englishText = "If the weather is good, and the sun is shining, go for a walk."
        let englishLanguage = viewModel.languages[0]

        // Before tokenization, sentences should be empty
        XCTAssertTrue(viewModel.sentences.isEmpty)

        viewModel.tokenize(text: englishText, for: englishLanguage)
        // After tokenization, sentences should be populated
        XCTAssertFalse(viewModel.sentences.isEmpty)
        XCTAssertEqual(viewModel.sentences[0].string, englishText)
    }

    func testTokenizeSpanish() {
        viewModel.viewDidLoad()
        let spanishText = "Si el clima está bueno y el sol está brillando, sal a pasear."
        let spanishLanguage = viewModel.languages[1]

        // Before tokenization, sentences should be empty
        XCTAssertTrue(viewModel.sentences.isEmpty)

        viewModel.tokenize(text: spanishText, for: spanishLanguage)
        // After tokenization, sentences should be populated
        XCTAssertFalse(viewModel.sentences.isEmpty)
    }
    
}
