//
//  Utilities.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 9/22/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
class Utilities: NSObject {
    static let share = Utilities()
    
    func createVCwith(_ nameSB: String, _ nameVC: String) -> UIViewController {
        return UIStoryboard.init(name: nameSB, bundle: nil).instantiateViewController(withIdentifier: nameVC)
    }
    
    
    func alertMessageOneBtn(_ title: String,_ message: String, _ button: String,_ view: UIViewController){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        view.present(alert, animated: true, completion: nil)
    }
    
    
    
//    //USER DEFAULT
//    func getAdmin() -> AdminModal{
//        if let data = UserDefaults.standard.value(forKey: "admin") as? Data {
//            return try! PropertyListDecoder().decode(AdminModal.self, from: data)
//        }
//        return AdminModal.init("", "", "", "", "", [UserModal.init("", "", "")])
//    }
//    
//    func setAdmin(_ admin: AdminModal){
//        UserDefaults.standard.set(try? PropertyListEncoder().encode(admin), forKey :"admin")
//        UserDefaults.standard.synchronize()
//    }
//    func updateAdminForEmail(_ newAdmin:AdminModal,_ oldEmail: String){
//        
//    }
    
    
}
