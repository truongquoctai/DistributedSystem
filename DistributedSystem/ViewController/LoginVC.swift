//
//  LoginVC.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 9/22/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.

import UIKit
import SocketIO
import SwiftyJSON
import UserNotifications

class LoginVC: UIViewController,BaseButtonDelegate {
    
    func onBtn(view: UIView, button: UIButton) {
      

        SocketIOManager.shared.socket!.on("send_device"){data, ack in
            print("send done")
        }
        let send = ["name":"IOS"]
        SocketIOManager.shared.emidServer("connected", [send])
        let login = ["username":vUserName.txtTextField.text,"password":vPassword.txtTextField.text]
        
        SocketIOManager.shared.emidServer("login",[login])
        SocketIOManager.shared.onNotification()
        if SocketIOManager.shared.checkConnected(SocketIOManager.shared.socket){
           
            SocketIOManager.shared.socket!.on("login-thanh-cong") {data, ack in
                print("login-thang-cong")
                var value = JSON(data)
                do{
                    value = value[0]
                    if(self.vUserName.txtTextField.text == "admin"){
                        let admin = try JSONDecoder().decode(AdminModal.self, from: value["admin"].rawData())
                        self.delegate.admin = admin
                        let dataAdmin = value["admin"]
                        let listUser = try JSONDecoder().decode([UserModal].self, from: dataAdmin["users"].rawData())
                        self.delegate.listUser = listUser
                    }
                    else{
                        let user = try JSONDecoder().decode(UserModal.self, from: value["user"].rawData())
                        self.delegate.user = user
                    }
                    let home = try JSONDecoder().decode(HomeModal.self, from: value["home"].rawData())
                    self.delegate.home = home
                }
                catch{
                    print("err")
                }
                    self.alertMessageTwoBtn("Thông Báo!!!", "Bạn có muốn lưu mật khẩu?", "YES", "NO", self)
            }
            SocketIOManager.shared.socket!.on("login-that-bai") {data, ack in
                self.alertMessage("ERROR", "Incorrect username or password", "OK", self)
            }
        }
        else{
            SocketIOManager.shared.connectSocket()
        }
    }
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var vLogo: UIView!
    @IBOutlet weak var vUserName: BaseTextField!
    @IBOutlet weak var vPassword: BaseTextField!
    
    @IBAction func onBtnForgot(_ sender: Any) {
        let vc = Utilities.share.createVCwith(nameStoryboard.nameSB, nameVC.ForgotPassVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBOutlet weak var vBtnLogin: BaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
        self.vBtnLogin.delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {
        self.vUserName.txtTextField.text = ""
        self.vPassword.txtTextField.text = ""
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - UserNotifications
    func scheduleNotification(notificationType: String) {
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        
        content.title = notificationType
        content.body = "This is example how to create " + notificationType
        content.sound = UNNotificationSound.default
        content.badge = 1
    }
    
    
    func setViews(){
        self.vUserName.txtTextField.placeholder = "Username"
        self.vPassword.txtTextField.placeholder = "Password"
        self.vPassword.txtTextField.isSecureTextEntry = true
        self.vBtnLogin.btnButton.setTitle("Login", for: .normal)
    }
    func alertMessage(_ title: String,_ message: String, _ button: String,_ view: UIViewController){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: { _ in        }))
        // show the alert
        view.present(alert, animated: true, completion: nil)
    }
    
    func alertMessageTwoBtn(_ title: String,_ message: String, _ button1: String, _ button2: String,_ view: UIViewController){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: button2, style: UIAlertAction.Style.default, handler: { _ in
            print("0")
            let vc = Utilities.share.createVCwith(nameStoryboard.nameSB, nameVC.MainVC)
            self.delegate.nvc.present(vc, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: button1, style: UIAlertAction.Style.default, handler: { _ in
            print("1")
            let vc = Utilities.share.createVCwith(nameStoryboard.nameSB, nameVC.MainVC)
            self.navigationController?.present(vc, animated: true, completion: nil)
        }))
        // show the alert
        view.present(alert, animated: true, completion: nil)
    }
}

