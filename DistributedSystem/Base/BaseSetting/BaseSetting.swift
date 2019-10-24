//
//  BaseSetting.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 10/2/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
protocol BaseSettingDelegate {
    func click(_ btn: UIButton,_ view:UIView)
}
@IBDesignable
class BaseSetting: UIView {
    var delegate : BaseSettingDelegate?
    @IBOutlet var vContainer: UIView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var imgRight: UIImageView!
    @IBAction func onBtn(_ sender: Any) {
        self.delegate?.click(btn, self)
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
        let bundle =  Bundle(for: BaseSetting.self)
        bundle.loadNibNamed("BaseSetting", owner: self, options: nil)
        self.vContainer.fixInView(self)
    }
}
