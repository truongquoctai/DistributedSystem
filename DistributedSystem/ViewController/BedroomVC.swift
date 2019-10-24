//
//  BedroomVC.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 10/6/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
import SwiftyJSON

class BedroomVC: UIViewController,BaseFeatureDelegate {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    func click(Button: UIButton, view: UIView) {
        if(view == vlightMain){
            if(self.lightMain){
                self.lightMain = false
                self.delegate.home!.bed.statusLightMain = lightMain
                self.vlightMain.img.image = UIImage.init(named: "light_off")
                self.vlightMain.lblStatus.text = "Off"
                
            }
            else
            {
                self.lightMain = true
                self.delegate.home!.bed.statusLightMain = lightMain
                self.vlightMain.img.image = UIImage.init(named: "light_on")
                self.vlightMain.lblStatus.text = "On"
            }
            self.onServer()
            let dataSend = ["status":self.lightMain]
            SocketIOManager.shared.emidServer("bed-light-main", [dataSend])
        }
        else if(view == vlightExtra){
            if(self.lightExtra){
                self.lightExtra = false
                self.delegate.home!.bed.statusLightExtra = lightExtra
                self.vlightExtra.img.image = UIImage.init(named: "light_off")
                self.vlightExtra.lblStatus.text = "Off"
                
            }
            else
            {
                self.lightExtra = true
                self.delegate.home!.bed.statusLightExtra = lightExtra
                self.vlightExtra.img.image = UIImage.init(named: "light_on")
                self.vlightExtra.lblStatus.text = "On"
            }
            self.onServer()
            let dataSend = ["status":self.lightExtra]
            SocketIOManager.shared.emidServer("bed-light-extra", [dataSend])
        }
        
    }
    
    @IBOutlet weak var vlightMain: BaseFeature!
    @IBOutlet weak var vlightExtra: BaseFeature!
    var lightMain = false
    var lightExtra = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vlightMain.delegate = self
        self.vlightExtra.delegate = self
        self.setview()
        self.navigationController?.isNavigationBarHidden = true
        self.vlightMain.layer.cornerRadius = 20
        self.vlightExtra.layer.cornerRadius = 20
    }
    override func viewWillAppear(_ animated: Bool) {
        self.onServer()
    }
    func setview(){
        self.lightMain = delegate.home!.bed.statusLightMain
        self.lightExtra = delegate.home!.bed.statusLightExtra
        self.vlightMain.lblInfo.text = "Light"
        self.vlightExtra.lblInfo.text = "Night Light"
        if(lightMain){
            self.vlightMain.img.image = UIImage.init(named: "light_on")
            self.vlightMain.lblStatus.text = "On"
        }
        else{
            self.vlightMain.img.image = UIImage.init(named: "light_off")
            self.vlightMain.lblStatus.text = "Off"
        }
        if(lightExtra){
            self.vlightExtra.img.image = UIImage.init(named: "light_on")
            self.vlightExtra.lblStatus.text = "On"
        }
        else{
            self.vlightExtra.img.image = UIImage.init(named: "light_off")
            self.vlightExtra.lblStatus.text = "Off"
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
                print("done")
            }
            catch{
                print("errr")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
