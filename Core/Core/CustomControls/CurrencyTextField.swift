//
//  CurrencyTextField.swift
//  CurrencyTextFieldDemo
//
//  Created by Deshmukh,Richa on 6/2/16.
//  Copyright © 2016 Richa. All rights reserved.
//

import UIKit

@IBDesignable open class CurrencyTextField : UITextField {
    private let maxDigits = 12

    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        return formatter
    }()

    // MARK: Private variables

    private var defaultValue = 0.00

    private var previousValue = String.empty

    // MARK: Computed variables

    var value: Double {
        get { return Double(getCleanNumberString()).or(0) / 100 }
        set { setAmount(newValue) }
    }

    // MARK: Initializers

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setupTextField()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupTextField()
    }

    // MARK: Override functions

    override open func willMove(toSuperview newSuperview: UIView?) {
        guard newSuperview != nil else {
            return NotificationCenter.default.removeObserver(self)
        }

        NotificationCenter.default.addObserver(
            self, selector: .textDidChange, name: UITextField.textDidChangeNotification, object: self
        )
    }

    // MARK: Private functions

    private func setupTextField(){
        keyboardType = .decimalPad

        setAmount(defaultValue)
    }

    private func setAmount (_ amount : Double){
        let textFieldStringValue = currencyFormatter.string(from: NSNumber(value: amount))

        text = textFieldStringValue

        textFieldStringValue.flatMap { previousValue = $0 }
    }

    private func getCleanNumberString() -> String {
        return text.or(.empty).components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

    private func getOriginalCursorPosition() -> Int{
        guard let selectedTextRange = selectedTextRange else { return 0 }

        return offset(from: beginningOfDocument, to: selectedTextRange.start)
    }

    private func setCursorOriginalPosition(_ cursorOffset: Int, oldTextFieldLength : Int?) {
        let newLength = text?.count
        let startPosition = beginningOfDocument

        if let oldTextFieldLength = oldTextFieldLength, let newLength = newLength, oldTextFieldLength > cursorOffset {
            let newOffset = newLength - oldTextFieldLength + cursorOffset
            let newCursorPosition = position(from: startPosition, offset: newOffset)

            if let newCursorPosition = newCursorPosition {
                let newSelectedRange = textRange(from: newCursorPosition, to: newCursorPosition)

                selectedTextRange = newSelectedRange
            }
        }
    }

    // MARK: Fileprivate functions

    @objc fileprivate func textDidChange(_ notification: Notification) {
        let cursorOffset = getOriginalCursorPosition()
        let cleanNumericString = getCleanNumberString()
        let textFieldLength = text?.count
        let textFieldNumber = Double(cleanNumericString)

        if cleanNumericString.count <= maxDigits && textFieldNumber != nil {
            setAmount(textFieldNumber! / 100)
        } else {
            text = previousValue
        }

        setCursorOriginalPosition(cursorOffset, oldTextFieldLength: textFieldLength)
    }
}

private extension Selector {
    static let textDidChange = #selector(CurrencyTextField.textDidChange)
}
