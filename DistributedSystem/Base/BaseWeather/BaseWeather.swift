//
//  BaseWeather.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 10/6/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
@IBDesignable
class BaseWeather: UIView {
    @IBOutlet var vContainer: UIView!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var img: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    func defaultInit(){
        let bundle =  Bundle(for: BaseWeather.self)
        bundle.loadNibNamed("BaseWeather", owner: self, options: nil)
        self.vContainer.fixInView(self)
    }


}
