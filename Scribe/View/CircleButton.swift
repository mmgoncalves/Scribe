//
//  CircleButton.swift
//  Scribe
//
//  Created by Mateus Marques on 06/12/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
    

}
