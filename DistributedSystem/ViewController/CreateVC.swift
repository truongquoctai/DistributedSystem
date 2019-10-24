//
//  CreateVC.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 10/8/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON

class CreateVC: UIViewController {
    @IBOutlet weak var vUsername: BaseTextField!
    @IBOutlet weak var vFullnam: BaseTextField!
    @IBOutlet weak var vPassword: BaseTextField!
    @IBOutlet weak var vConfirmPass: BaseTextField!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnCreate: UIButton!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    @IBAction func btnOnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onBtnCreate(_ sender: Any) {
        if(!self.vUsername.txtTextField.checkTextField()){
            self.alertMessage("ERROR", "Enter username before create!", "OK", self)
        }
        else if(!self.vFullnam.txtTextField.checkTextField()){
            self.alertMessage("ERROR", "Enter fullname before create!", "OK", self)
        }
        else if(!self.vPassword.txtTextField.checkTextField()){
            self.alertMessage("ERROR", "Enter password before create!", "OK", self)
        }
        else if(!self.vConfirmPass.txtTextField.checkTextField()){
            self.alertMessage("ERROR", "Confirm password before create!", "OK", self)
        }
        else if(self.vPassword.txtTextField.text != self.vConfirmPass.txtTextField.text){
            self.alertMessage("ERROR", "Incorrect password!", "OK", self)
        }
        else{
            let data = ["username":self.vUsername.txtTextField.text!, "password":self.vPassword.txtTextField.text!, "fullname":self.vFullnam.txtTextField.text!]
            SocketIOManager.shared.emidServer("create-new-user", [data])
            SocketIOManager.shared.socket!.on("thanh-cong") {data, ack in
                var value = JSON(data)
                do{
                    value = value[0]
                    print("dang lay value 0")
                    print("dang lay value 1")
                    print("dang lay value 2")
                    let listUser = try JSONDecoder().decode([UserModal].self, from: value["user"].rawData())
                    self.delegate.listUser = listUser
                }
                catch{
                    print("err")
                }
                print("reset-that-bai")
                self.alertMessageCreate("Congratulation", "Create user success!", "OK", self)
            }
            SocketIOManager.shared.socket!.on("that-bai") {data, ack in
                print("reset-that-bai")
                SVProgressHUD.dismiss()
                self.alertMessageCreate("Error", "Create user fail!", "OK", self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.setview()
    }
    func setview(){
        self.vUsername.txtTextField.placeholder = "Username"
        self.vFullnam.txtTextField.placeholder = "Fullname"
        self.vPassword.txtTextField.placeholder = "Password"
        self.vConfirmPass.txtTextField.placeholder = "Confirm pasword"
        self.btnCancel.layer.cornerRadius = self.btnCancel.bounds.height/3
        self.btnCreate.layer.cornerRadius = self.btnCreate.bounds.height/3
        self.vPassword.txtTextField.isSecureTextEntry = true
        self.vConfirmPass.txtTextField.isSecureTextEntry = true
    }
    
    func alertMessage(_ title: String,_ message: String, _ button: String,_ view: UIViewController){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: { _ in        }))
        // show the alert
        view.present(alert, animated: true, completion: nil)
    }
    func alertMessageCreate(_ title: String,_ message: String, _ button: String,_ view: UIViewController){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: { _ in        }))
            self.navigationController?.popViewController(animated: true)
        view.present(alert, animated: true, completion: nil)
    }
}
extension UITextField{
    func checkTextField() ->Bool{
        if(self.text == ""){
            return false
        }
        else{
            return true
        }
    }
}


