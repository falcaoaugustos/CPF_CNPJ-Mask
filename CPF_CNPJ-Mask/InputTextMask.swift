//
//  CPFCPNJMask.swift
//  CPF_CNPJ-Mask
//
//  Created by Augusto Falcão on 1/12/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

import Foundation

public enum MaskType: String {
    case CPF = "***.***.***-**"
    case CNPJ = "**.***.***/****-**"
    case birthday = "**/**/****"
}

class InputTextMask {
    private static func stringFilterWithCharacter(_ char: Character) -> Bool {
        return char != "." && char != "/" && char != "-"
    }

    private static func transformStringToFilteredCharCollection(_ text: String) -> [Character] {
        var filteredText = [Character]()

        text.filter { (char) -> Bool in
            InputTextMask.stringFilterWithCharacter(char)
        }.forEach { (char) in
            filteredText.append(char)
        }

        return filteredText
    }

    private static func transformCharCollectionToString(_ chars: [Character]) -> String {
        var rawString = ""

        chars.forEach { (char) in
            rawString += String(char)
        }

        return rawString
    }

    private static func transformCharCollectionToMaskedString(_ chars: [Character], mask: MaskType) -> String {
        let textLength = chars.count
        var textIndex = 0
        var maskedString = ""

        mask.rawValue.forEach { (char) in
            if textIndex < textLength {
                if char == "*" {
                    maskedString += String(chars[textIndex])
                    textIndex += 1
                } else  {
                    maskedString += String(char)
                }
            }
        }

        return maskedString
    }

    public static func filterMaskFromText(_ text: String) -> String {
        let filteredCharCollection = InputTextMask.transformStringToFilteredCharCollection(text)

        return InputTextMask.transformCharCollectionToString(filteredCharCollection)
    }

    public static func applyMask(_ mask: MaskType, toText text: String) -> String {
        let filteredCharCollection = InputTextMask.transformStringToFilteredCharCollection(text)

        return InputTextMask.transformCharCollectionToMaskedString(filteredCharCollection, mask: mask)
    }
}
