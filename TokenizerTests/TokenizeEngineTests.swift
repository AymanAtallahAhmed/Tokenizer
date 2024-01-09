//
//  TokenizeEngineTests.swift
//  TokenizerTests
//
//  Created by Attaallah Ayman, Vodafone on 09/01/2024.
//

import XCTest
@testable import Tokenizer

final class TokenizeEngineTests: XCTestCase {
    var tokenizeEngine: TokenizeEngineProtocol!

    override func setUp() {
        tokenizeEngine = TokenizeEngine()
    }

    override func tearDown() {
        tokenizeEngine = nil
        super.tearDown()
    }

    func testEnglishTokenization() {
        let englishText = "If the weather is good, and the sun is shining, go for a walk."
        let language = Language.En(name: "English", words: ["If", "and"])
        let tokens = tokenizeEngine.tokenize(text: englishText, language: language)
        XCTAssertEqual(tokens.count, 2)
        XCTAssertEqual(tokens[0].string, "If the weather is good, ")
        XCTAssertEqual(tokens[1].string, "and the sun is shining, go for a walk. ")
    }

    func testSpanishTokenization() {
        let spanishText = "Si el clima está bueno, Y el sol está brillando, sal a pasear."
        let language = Language.Sp(name: "Spanish", words: ["Si", "Y"])

        let tokens = tokenizeEngine.tokenize(text: spanishText, language: language)
        XCTAssertEqual(tokens.count, 2)
        XCTAssertEqual(tokens[0].string, "Si el clima está bueno, ")
        XCTAssertEqual(tokens[1].string, "Y el sol está brillando, sal a pasear. ")
    }

    func testEmptySentenceTokenization() {
        let emptyText = ""
        let language = Language.En(name: "English", words: ["If", "and"])

        let tokens = tokenizeEngine.tokenize(text: emptyText, language: language)
        XCTAssertTrue(tokens.isEmpty)
    }

    func testInvalidRegexPattern() {
        let invalidText = "This is a test."
        let language = Language.En(name: "English", words: ["invalid"])
        XCTAssertEqual(tokenizeEngine.tokenize(text: invalidText, language: language), [])
    }
    
}
