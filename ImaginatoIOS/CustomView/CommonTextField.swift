//
//  CommonTextField.swift
//  TestLogin
//
//  Created by NHK on 1/25/21.
//  Copyright © 2021 NHK. All rights reserved.
//

import UIKit

class CommonTextField: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBInspectable var errorText: String = "" {
        didSet {
            errorLabel.text = errorText
        }
    }
    
    @IBInspectable var isSecure: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecure
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CommonTextField", owner: self, options: nil)
        self.addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
