//
//  CustomButton.swift
//  Calculator
//
//  Created by Chhaileng Peng on 6/2/18.
//  Copyright © 2018 Chhaileng Peng. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
}
