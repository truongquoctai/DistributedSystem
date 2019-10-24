//
//  BaseNavigation.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 9/25/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
protocol BaseNavigationDelegate {
    func onBtn(view: UIView, btn:UIButton)
}
@IBDesignable
class BaseNavigation: UIView {
    
    
    @IBOutlet var vContainer: UIView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnFeature: UIButton!
    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    var delegate:BaseNavigationDelegate?
    @IBAction func onBtnHome(_ sender: Any) {
        self.delegate?.onBtn(view: self, btn: btnHome)
    }
    @IBAction func onBtnFeature(_ sender: Any) {
        self.delegate?.onBtn(view: self, btn: btnFeature)
    }
    @IBAction func onBtnUser(_ sender: Any) {
        self.delegate?.onBtn(view: self, btn: btnUser)
    }
    @IBAction func onBtnSetting(_ sender: Any) {
        self.delegate?.onBtn(view: self, btn: btnSetting)
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
        let bundle =  Bundle(for: BaseNavigation.self)
        bundle.loadNibNamed("BaseNavigation", owner: self, options: nil)
        self.vContainer.fixInView(self)
//        self.btnButton.layer.cornerRadius = self.btnButton.frame.height/2
    }
}
