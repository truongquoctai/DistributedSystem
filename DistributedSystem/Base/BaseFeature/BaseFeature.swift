//
//  BaseFeature.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 10/6/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
protocol BaseFeatureDelegate {
    func click(Button: UIButton, view: UIView)
}
@IBDesignable
class BaseFeature: UIView {
    @IBOutlet var vContainer: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btn: UIButton!
    var delegate: BaseFeatureDelegate?
    
    @IBAction func onBtn(_ sender: Any) {
        self.delegate?.click(Button: btn, view: self)
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
        let bundle =  Bundle(for: BaseFeature.self)
        bundle.loadNibNamed("BaseFeature", owner: self, options: nil)
        self.vContainer.fixInView(self)
        self.vContainer.layer.cornerRadius = 20
    }
}
