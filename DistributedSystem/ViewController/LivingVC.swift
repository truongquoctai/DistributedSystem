//
//  LivingVC.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 10/6/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
import  SwiftyJSON

class LivingVC: UIViewController,BaseFeatureDelegate {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    func click(Button: UIButton, view: UIView) {
        if(view == vLight){
            if(self.light){
                self.light = false
                self.delegate.home!.living.statusLight = light
                self.vLight.img.image = UIImage.init(named: "light_off")
                self.vLight.lblStatus.text = "Off"
            }
            else
            {
                self.light = true
                self.delegate.home!.living.statusLight = light
                self.vLight.img.image = UIImage.init(named: "light_on")
                self.vLight.lblStatus.text = "On"
            }
            self.onServer()
            let dataSend = ["status":self.light]
            SocketIOManager.shared.emidServer("living-light", [dataSend])
        }
        else if(view == vFan){
            if(self.fan){
                self.fan = false
                self.delegate.home!.living.fan = fan
                self.vFan.img.image = UIImage.init(named: "fan_off")
                self.vFan.lblStatus.text = "Off"
                
            }
            else
            {
                self.fan = true
                self.delegate.home!.living.fan = fan
                self.vFan.img.image = UIImage.init(named: "fan_on")
                self.vFan.lblStatus.text = "On"
            }
            self.onServer()
            let dataSend = ["status":self.fan]
            SocketIOManager.shared.emidServer("living-fan", [dataSend])
        }
    }
    
    @IBOutlet weak var vLight: BaseFeature!
    @IBOutlet weak var vFan: BaseFeature!
    var light = false
    var fan = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setview()
        self.vFan.delegate = self
        self.vLight.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        self.light = delegate.home!.living.statusLight
        self.fan = delegate.home!.living.fan
      
    }
    override func viewWillAppear(_ animated: Bool) {
        self.onServer()
    }
    func onServer(){
        SocketIOManager.shared.socket!.on("light"){data, ack in
            var value = JSON(data)
            do{
                value = value[0]
                let den = value["den"]
                let status = value["status"]
                var st:Bool?
                if(status == "true"){
                    st = true
                }
                else{
                    st = false
                }
                switch(den){
                case 1:
                    self.delegate.home!.living.statusLight = st!
                    break;
                case 2:
                    self.delegate.home!.living.fan = st!
                    break;
                case 3:
                    self.delegate.home!.kitchen.statusLight = st!
                    break;
                case 4:
                    self.delegate.home!.bed.statusLightMain = st!
                    break;
                case 5:
                    self.delegate.home!.bed.statusLightExtra = st!
                    break;
                case 6:
                    self.delegate.home!.bath.statusLight = st!
                    break;
                case 7:
                    self.delegate.home!.door.status = st!
                    break;
                default:
                    break;
                }
                self.setview()
            }
            catch{
                print("errr")
            }
        }
    }
    func setview(){
        self.vLight.layer.cornerRadius = 20
        self.vFan.layer.cornerRadius = 20
        self.light = delegate.home!.living.statusLight
        self.fan = delegate.home!.living.fan
        self.vLight.lblInfo.text = "Light"
        self.vFan.lblInfo.text = "Air Conditioner"
        if(self.light){
            self.vLight.lblStatus.text = "On"
            self.vLight.img.image = UIImage.init(named: "light_on")
        }
        else{
            self.vLight.lblStatus.text = "Off"
            self.vLight.img.image = UIImage.init(named: "light_off")
        }
        if(self.fan){
            self.vFan.lblStatus.text = "On"
            self.vFan.img.image = UIImage.init(named: "fan_on")
        }
        else{
            self.vFan.lblStatus.text = "Off"
            self.vFan.img.image = UIImage.init(named: "fan_off")
        }
    }
    
}
