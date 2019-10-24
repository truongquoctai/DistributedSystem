//
//  BaseButton.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 9/25/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit

protocol BaseButtonDelegate {
    func onBtn(view: UIView,button: UIButton)
}

@IBDesignable
class BaseButton: UIView {
    @IBOutlet var vContainer: UIView!
    @IBOutlet weak var btnButton: UIButton!
    var delegate : BaseButtonDelegate?
    @IBAction func onBtnButton(_ sender: Any) {
        delegate?.onBtn(view: self, button: btnButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    func defaultInit(){
        let bundle =  Bundle(for: BaseButton.self)
        bundle.loadNibNamed("BaseButton", owner: self, options: nil)
        self.vContainer.fixInView(self)
        self.btnButton.layer.cornerRadius = self.btnButton.frame.height/2
    }
}

