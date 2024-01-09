//
//  TokenizerViewControllerTests.swift
//  TokenizerTests
//
//  Created by Attaallah Ayman, Vodafone on 09/01/2024.
//

import XCTest
@testable import Tokenizer

final class TokenizerViewControllerTests: XCTestCase {
    
    var viewController: TokenizerViewController!
    var viewModel: TokenizerViewModelProtocol!
    var tokenizeEngine: TokenizeEngineProtocol!
    
    override func setUp() {
        super.setUp()
        tokenizeEngine = TokenizeEngineMock()
        viewModel = TokenizerViewModel(tokenizeEngine: tokenizeEngine)
        viewController = TokenizerViewController(viewModel: viewModel)
        viewController.loadView()
    }

    override func tearDown() {
        tokenizeEngine = nil
        viewModel = nil
        viewController = nil
        super.tearDown()
    }

    func testUIElementsExist() {
        XCTAssertNotNil(viewController.titleLabel)
        XCTAssertNotNil(viewController.inputTextView)
        XCTAssertNotNil(viewController.generateButton)
        XCTAssertNotNil(viewController.sentencesTableView)
        XCTAssertNotNil(viewController.languagePicker)
    }

    func testBindings() {
        viewController.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            XCTAssertEqual(self?.viewController.languages.count, 2)
            XCTAssertEqual(self?.viewController.sentences.count, 1)
        }
    }

    func testGenerateTokensButton() {
        // Simulate user entering text
        let userText = "This is a test text"
        viewController.inputTextView.text = userText

        // Simulate selecting a language
        viewController.languages = [.En(name: "English", words: ["and", "if"])]
        viewController.languagePicker.reloadAllComponents()
        viewController.languagePicker.selectRow(0, inComponent: 0, animated: false)

        // Simulate tapping the Generate Tokens button
        viewController.generateTokens()

        // Assert that the view model's tokenize method is called
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            XCTAssertEqual(self?.viewController.sentences.count, 1)
            XCTAssertEqual(self?.viewController.sentences[0].string, userText)
        }
    }
}
