//
//  StylishTextField.swift
//  HomepwnerBNR
//
//  Created by Anatoliy Chernyuk on 1/8/18.
//  Copyright © 2018 Anatoliy Chernyuk. All rights reserved.
//

import UIKit

class StylishTextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        self.borderStyle = .bezel
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        borderStyle = .roundedRect
        return super.resignFirstResponder()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
