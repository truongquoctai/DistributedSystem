//
//  SettingVC.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 9/25/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit

class SettingVC: UIViewController,BaseSettingDelegate {
    func click(_ btn: UIButton, _ view: UIView) {
        switch view {
        case vLogOut:
            self.showSimpleAlert()
            break
        case vChangePassword:
            let vc = Utilities.share.createVCwith(nameStoryboard.nameSB, nameVC.ChangePassVC)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case vTurnOffAllLight:
            self.alertTurnOff()
            break
        default:
            break
        }
    }
    @IBOutlet weak var vChangePassword: BaseSetting!
    @IBOutlet weak var vNotification: BaseSetting!
    @IBOutlet weak var vLanguage: BaseSetting!
    @IBOutlet weak var vFeedBack: BaseSetting!
    @IBOutlet weak var vLogOut: BaseSetting!
    @IBOutlet weak var vTurnOffAllLight: BaseSetting!
    
    var delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vLogOut.delegate = self
        self.vTurnOffAllLight.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        self.setview()
    }
    func setview(){
        self.vChangePassword.imgLeft.image = UIImage.init(named: "ico_privacy")
        self.vNotification.imgLeft.image = UIImage.init(named: "ico_noti")
        self.vLanguage.imgLeft.image = UIImage.init(named: "ico_language")
        self.vFeedBack.imgLeft.image = UIImage.init(named: "ico_feedback")
        self.vLogOut.imgLeft.image = UIImage.init(named: "ico_logout")
        self.vTurnOffAllLight.imgLeft.image = UIImage.init(named: "light_off")
        self.vChangePassword.btn.setTitle("Change Password", for: .normal)
        self.vNotification.btn.setTitle("Notification", for: .normal)
        self.vLanguage.btn.setTitle("Language", for: .normal)
        self.vFeedBack.btn.setTitle("Feedback", for: .normal)
        self.vLogOut.btn.setTitle("Logout", for: .normal)
        self.vTurnOffAllLight.btn.setTitle("Turn off device", for: .normal)
    }
    func showSimpleAlert() {
        let alert = UIAlertController(title: "Log Out?", message: "You can always access your content by signing back in", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            return
        }))
        alert.addAction(UIAlertAction(title: "Log Out", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
            SocketIOManager.shared.emidServer("logout", [])
            self.delegate.nvc.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func alertTurnOff() {
        let alert = UIAlertController(title: "Turn off all device?", message: "Do you want to turn off all device in your home!!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            return
        }))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
            SocketIOManager.shared.emidServer("off-all-light", [])
            return
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
