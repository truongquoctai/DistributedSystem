//
//  UserVC.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 9/25/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    
    @IBOutlet weak var vAllInfo: UIView!
    @IBOutlet weak var vName: UIView!
    @IBOutlet weak var vPhone: UIView!
    @IBOutlet weak var vEmail: UIView!
    @IBOutlet weak var vUsername: UIView!
    @IBOutlet weak var vPassword: UIView!
    
    @IBOutlet weak var tbvListUser: UITableView!
    @IBAction func onBtnChangeName(_ sender: Any) {
        showSimpleAlert(self.lblName, "Change Fullname", "Enter your name", "OK")
    }
    
    @IBAction func onBtnChangePhone(_ sender: Any) {
        if(self.delegate.admin.username == "admin")
        {
            showSimpleAlert(self.lblPhone, "Change Phone", "Enter your phone", "OK")
        }
        else{
            let alert = UIAlertController(title: "ERROR", message: "You don't have phone number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in        }))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func onBtnSeePassword(_ sender: Any) {
        //face id true => mở
    }
    @IBAction func onBtnCreateAccount(_ sender: Any) {
        if(delegate.admin.username == "admin"){
            let vc = Utilities.share.createVCwith(nameStoryboard.nameSB, nameVC.CreateVC)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let alert = UIAlertController(title: "ERROR", message: "You are not admin!!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in        }))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbvListUser.delegate = self
        self.tbvListUser.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
        self.setview()
        self.tbvListUser.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.tbvListUser.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.onListUser()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tbvListUser.reloadData()
    }
    func setview(){
        self.imgAvatar.layer.cornerRadius = self.imgAvatar.frame.height/2
        self.vAllInfo.layer.cornerRadius = 20
        self.vName.layer.cornerRadius = 10
        self.vPhone.layer.cornerRadius = 10
        self.vEmail.layer.cornerRadius = 10
        self.vUsername.layer.cornerRadius = 10
        self.vPassword.layer.cornerRadius = 10
        if(self.delegate.admin.username == "admin"){
            self.lblName.text = "Name: " + delegate.admin.fullname
            self.lblPhone.text = "Phone: " + delegate.admin.phone
            self.lblEmail.text = "Email: " + delegate.admin.email
            self.lblUsername.text = "Username: " + delegate.admin.username
            self.lblPassword.text = "Password: *************"
        }
        else{
            self.lblName.text = "Name: " + delegate.user.fullname
            self.lblPhone.text = "Phone: "
            self.lblEmail.text = "Email: "
            self.lblUsername.text = "Username: " + delegate.user.username
            self.lblPassword.text = "Password: *************"
        }
       
        
    }
    
    func showSimpleAlert(_ lable:UILabel,_ titleAlert: String,_ message: String,_ titleAction: String ){
        let alert = UIAlertController(title: titleAlert, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: titleAction, style: UIAlertAction.Style.default, handler: { _ in
            let text = (alert.textFields?.first as! UITextField).text
            if(text != ""){
                if(lable == self.lblName){
                    self.lblName.text = "Name: " + text!
                    if(self.delegate.admin.fullname != text!)
                    {
                        self.delegate.admin.fullname = text!
                        let dataSend = ["change":text!]
                        SocketIOManager.shared.emidServer("change-name", [dataSend])
                    }
                    
                }
                else if(lable == self.lblPhone){
                    self.lblPhone.text = "Phone: " + text!
                    if(self.delegate.admin.phone != text!)
                    {
                        self.delegate.admin.phone = text!
                        let dataSend = ["change":text!]
                        SocketIOManager.shared.emidServer("change-phone", [dataSend])
                    }
                }
                return
            }else{
                return
            }
        }))
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - TableView User
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.listUser.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let user = delegate.listUser[indexPath.row]
        cell.lblFullname.text = user.fullname
        cell.lblUsername.text = user.username
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath.row)")
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let acDelete = UITableViewRowAction(style: .normal, title: "DELETE") { (action, indexPath) in
            print("DELETE")
            self.alertMessageTwoBtn("Confirm delete", "Do you want to delete user ?", "YES", "NO", self,indexPath.row)
        }
        acDelete.backgroundColor = .red
        return [acDelete]
    }
    
    //MARK : - Alert
    func alertMessageTwoBtn(_ title: String,_ message: String, _ button1: String, _ button2: String,_ view: UIViewController,_ indexpathRow: Int){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: button2, style: UIAlertAction.Style.default, handler: { _ in
            print("cant delete")
            
        }))
        alert.addAction(UIAlertAction(title: button1, style: UIAlertAction.Style.default, handler: { _ in
            print("delete")
            let datasend = ["username": "\(self.delegate.listUser[indexpathRow].username)"]
            SocketIOManager.shared.socket!.emit("deleteUser", with: [datasend])
            
           
        }))
        // show the alert
        view.present(alert, animated: true, completion: nil)
    }
    func onListUser(){
        SocketIOManager.shared.socket!.on("deleteDone") {data, ack in
            var value = JSON(data)
            do{
                value = value[0]
                let dataAdmin = value["admin"]
                let listUser = try JSONDecoder().decode([UserModal].self, from: dataAdmin["users"].rawData())
                self.delegate.listUser = listUser
                self.tbvListUser.reloadData()
            }
            catch{
                print("err")
            }
            
        }
        
    }

    
}
