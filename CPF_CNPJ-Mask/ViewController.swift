//
//  ViewController.swift
//  CPF_CNPJ-Mask
//
//  Created by Augusto Falcão on 1/12/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var CPFTextField: UITextField!
    @IBOutlet var CNPJTextField: UITextField!
    @IBOutlet var CPFCNPJTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        CPFTextField.becomeFirstResponder()
    }

    // MARK: Text Field Delegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text else { return false }

        switch textField {
        case CPFTextField:
            if  text.count == 14, string.count > 0 {
                return false
            }

            let numberPattern: MaskType = .CPF

            textField.text = string.count < 1 ?
                InputTextMask.applyMask(numberPattern, toText: String(text.dropLast())) :
                InputTextMask.applyMask(numberPattern, toText: text + string)

            return false
        case CNPJTextField:
            if text.count == 18, string.count > 0 {
                return false
            }

            let numberPattern: MaskType = .CNPJ

            textField.text = string.count < 1 ?
                InputTextMask.applyMask(numberPattern, toText: String(text.dropLast())) :
                InputTextMask.applyMask(numberPattern, toText: text + string)

            return false
        case CPFCNPJTextField:
            if text.count == 18, string.count > 0 {
                return false
            }

            let numberPattern: MaskType = text.count > 15 || (text.count > 13 && string.count > 0)
                ? .CNPJ : .CPF

            textField.text = string.count < 1 ?
                InputTextMask.applyMask(numberPattern, toText: String(text.dropLast())) :
                InputTextMask.applyMask(numberPattern, toText: text + string)

            return false
        default:
            return true
        }
    }
}

