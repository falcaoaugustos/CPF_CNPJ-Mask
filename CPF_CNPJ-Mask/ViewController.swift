//
//  ViewController.swift
//  CPF_CNPJ-Mask
//
//  Created by Augusto Falcão on 1/12/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var CPFCNPJTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        CPFCNPJTextField.becomeFirstResponder()
    }


    // MARK: Text Field Delegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == CPFCNPJTextField {
            if let count = textField.text?.count, count == 18, string.count > 0 {
                return false
            }

            guard let text = textField.text else { return false }

            let numberPattern: MaskType = text.count > 15 || (text.count > 13 && string.count > 0)
                ? .CNPJ : .CPF

            textField.text = string.count < 1 ?
                CPFCNPJMask.applyMask(numberPattern, toText: String(text.dropLast())) :
                CPFCNPJMask.applyMask(numberPattern, toText: text + string)

            return false
        }

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

