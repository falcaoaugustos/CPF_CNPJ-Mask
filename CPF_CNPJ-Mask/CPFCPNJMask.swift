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
}

class CPFCNPJMask {
    private static func stringFilterWithCharacter(_ char: Character) -> Bool {
        return char != "." && char != "/" && char != "-"
    }

    public static func applyMask(_ mask: MaskType, toText text: String) -> String {
        var filterdText = [Character]()

        text.filter { (char) -> Bool in
            CPFCNPJMask.stringFilterWithCharacter(char)
            }.forEach { (char) in
                filterdText.append(char)
        }

        let textLength = filterdText.count
        var textIndex = 0
        var result = ""

        mask.rawValue.forEach { (char) in
            if textIndex < textLength {
                if char == "*" {
                    result += String(filterdText[textIndex])
                    textIndex += 1
                } else  {
                    result += String(char)
                }
            }
        }

        return result
    }
}
