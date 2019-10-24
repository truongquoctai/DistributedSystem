//
//  KitchenVC.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 10/6/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
import SwiftyJSON

class KitchenVC: UIViewController,BaseFeatureDelegate {
    func click(Button: UIButton, view: UIView) {
        if(light){
            self.light = false
            self.delegate.home?.kitchen.statusLight = light
            self.vlight.img.image = UIImage.init(named: "light_off")
            self.vlight.lblStatus.text = "Off"
        }
        else{
            self.light = true
            self.delegate.home?.kitchen.statusLight = light
            self.vlight.img.image = UIImage.init(named: "light_on")
            self.vlight.lblStatus.text = "On"
        }
        self.onServer()
        let dataSend = ["status":self.light]
        SocketIOManager.shared.emidServer("kitchen-light", [dataSend])
        
    }
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var light = false
    @IBOutlet weak var vlight: BaseFeature!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vlight.delegate = self
        self.setview()
        self.navigationController?.isNavigationBarHidden = true
        self.vlight.layer.cornerRadius = 20
    }
    override func viewWillAppear(_ animated: Bool) {
        self.onServer()
    }
    func setview(){
        self.light = delegate.home!.kitchen.statusLight
        self.vlight.lblInfo.text = "Light"
        if(light){
            self.vlight.img.image = UIImage.init(named: "light_on")
            self.vlight.lblStatus.text = "On"
        }
        else{
            self.vlight.img.image = UIImage.init(named: "light_off")
            self.vlight.lblStatus.text = "Off"
        }
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
    
}
