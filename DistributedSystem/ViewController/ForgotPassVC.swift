//
//  ForgotPassVC.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 9/22/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
import SVProgressHUD

class ForgotPassVC: UIViewController,BaseButtonDelegate {
    func onBtn(view: UIView, button: UIButton) {
        let email = ["email":self.vEmail.txtTextField.text]
        SocketIOManager.shared.emidServer("forgot-password", [email])
        if SocketIOManager.shared.checkConnected(SocketIOManager.shared.socket){
            SVProgressHUD.show()
            SocketIOManager.shared.socket!.on("reset-thanh-cong") {data, ack in
                print("reset-thang-cong")
                SVProgressHUD.dismiss()
                self.alertMessageOneBtn("Thông Báo", "Mật khẩu mới đã được gửi tới email của bạn!", "OK", self)
            }
            SocketIOManager.shared.socket!.on("reset-that-bai") {data, ack in
                print("reset-that-bai")
                SVProgressHUD.dismiss()
                self.alertMessage("Thông Báo", "Email của bạn không tồn tại!", "OK", self)
            }
        }
        else{
            SocketIOManager.shared.connectSocket()
        }
    }
    
    @IBOutlet weak var vEmail: BaseTextField!
    @IBOutlet weak var vButton: BaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
        self.vButton.delegate = self
    }
    func setViews(){
        self.vEmail.txtTextField.placeholder = "Email"
        self.vButton.btnButton.setTitle("Sent", for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    func alertMessageOneBtn(_ title: String,_ message: String, _ button: String,_ view: UIViewController){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        // show the alert
        view.present(alert, animated: true, completion: nil)
    }
    func alertMessage(_ title: String,_ message: String, _ button: String,_ view: UIViewController){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: { _ in
        }))
        // show the alert
        view.present(alert, animated: true, completion: nil)
    }

}
