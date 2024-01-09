//
//  TokenizeEngine.swift
//  Tokenizer
//
//  Created by Attaallah Ayman, Vodafone on 08/01/2024.
//

import Foundation

class TokenizeEngine: TokenizeEngineProtocol{

    func tokenize(text: String, language: Language) -> [NSMutableAttributedString] {
        let pattern = buildPattern(for: language.words())

        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
            let nsRange = NSRange(text.startIndex..<text.endIndex, in: text)
            let matches = regex.matches(in: text, options: [], range: nsRange)
            let tokens = generateSentences(wholeSentence: text, matches: matches)
            return tokens
        } catch {
            print("Error creating regex: \(error)")
            return []
        }
    }

    private func buildPattern(for words: [String]) -> String {
        var patterns: [String] = []
        for word in words {
            let pattern = "\\b\(word)\\b"
            patterns.append(pattern)
        }
        return patterns.joined(separator: "|")
    }

    private func generateSentences(wholeSentence: String, matches: [NSTextCheckingResult]) -> [NSMutableAttributedString] {
        guard matches.count > 0 else { return [] }
        var sentences: [NSMutableAttributedString] = []
        var lastMatch = matches[0]
        var index = 0

        while index + 1 < matches.count {
            let match = matches[index]
            let nextMatch = matches[index + 1]
            guard
                let currentRange = Range(match.range, in: wholeSentence),
                let nextRange = Range(nextMatch.range, in: wholeSentence) else {
                index += 1
                continue
            }

            let matchedWord = String(wholeSentence[currentRange])
                .trimmingCharacters(in: .whitespacesAndNewlines)
            let nonMatchedString = String(wholeSentence[currentRange.upperBound..<nextRange.lowerBound])
                .trimmingCharacters(in: .whitespacesAndNewlines)
            let sentence = NSMutableAttributedString()
                .bold(matchedWord, size: 20)
                .normal(nonMatchedString, size: 16)
            sentences.append(sentence)
            lastMatch = nextMatch
            index += 1
        }

        guard let range = Range(lastMatch.range, in: wholeSentence) else { return sentences }
        let matchedWord = String(wholeSentence[range])
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let nonMatchedString = String(wholeSentence[range.upperBound..<wholeSentence.endIndex])
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let lastSentence = NSMutableAttributedString()
            .bold(matchedWord, size: 20)
            .normal(nonMatchedString, size: 16)
        sentences.append(lastSentence)

        return sentences
    }
}
