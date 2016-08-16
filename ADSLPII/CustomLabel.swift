//
//  CustomLabel.swift
//  ADSLPII
//
//  Created by John Lima on 15/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

@IBDesignable
class CustomLabel: UILabel {
    
    @IBInspectable
    var masksToBounds: Bool = true {
        didSet {
            layer.masksToBounds = self.masksToBounds
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable
    var backColor: UIColor = UIColor.clear {
        didSet {
            backgroundColor = self.backColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var leftEdge: CGFloat = 0.0
    @IBInspectable var rightEdge: CGFloat = 0.0
    @IBInspectable var topEdge: CGFloat = 0.0
    @IBInspectable var bottomEdge: CGFloat = 0.0
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: self.topEdge, left: self.leftEdge, bottom: self.bottomEdge, right: self.rightEdge)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    /*func intrinsicContentSize() -> CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += self.topEdge + self.bottomEdge
        intrinsicSuperViewContentSize.width += self.leftEdge + self.rightEdge
        return intrinsicSuperViewContentSize
    }*/

}
