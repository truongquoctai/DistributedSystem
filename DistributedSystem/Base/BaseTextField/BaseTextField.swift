//
//  BaseTextField.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 9/22/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
@IBDesignable
class BaseTextField: UIView {
    @IBOutlet var vContainer: UIView!
    @IBOutlet weak var txtTextField: UITextField!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    func defaultInit(){
        let bundle =  Bundle(for: BaseTextField.self)
        bundle.loadNibNamed("BaseTextField", owner: self, options: nil)
        self.vContainer.fixInView(self)
        self.txtTextField.layer.borderWidth = 1
        self.txtTextField.layer.cornerRadius = self.txtTextField.frame.height/2
    }
  

}
extension UIView{
    func fixInView(_ container: UIView) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    }
    
}
