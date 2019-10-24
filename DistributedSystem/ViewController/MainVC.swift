//
//  MainVC.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 9/25/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit

class MainVC: UIViewController,BaseNavigationDelegate {
    func onBtn(view: UIView, btn: UIButton) {
        if(btn == self.vNavigation.btnHome){
            self.changeBackgroundButton("home_selected", "features","user", "setting")
            self.addSubView(nvcHome, nvcFeature, nvcUser, nvcSetting)
        }
        else if(btn == self.vNavigation.btnFeature){
            self.changeBackgroundButton("home", "features_selected","user", "setting")
            self.addSubView(nvcFeature, nvcHome, nvcUser, nvcSetting)
        }
        else if(btn == self.vNavigation.btnUser){
            self.changeBackgroundButton("home", "features","user_selected", "setting")
            self.addSubView(nvcUser, nvcFeature, nvcHome, nvcSetting)
        }
        else{
            self.changeBackgroundButton("home", "features","user", "setting_selected")
            self.addSubView(nvcSetting, nvcFeature, nvcUser, nvcHome)
        }
    }
    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var vNavigation: BaseNavigation!
    var nvcHome: UINavigationController!
    var nvcFeature: UINavigationController!
    var nvcUser: UINavigationController!
    var nvcSetting: UINavigationController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.vNavigation.delegate = self
        //set first view
        self.changeBackgroundButton("home_selected", "features","user", "setting")
        self.addSubView(nvcHome, nvcFeature, nvcUser, nvcSetting)
        self.navigationController?.navigationBar.isHidden = true
    }
    func initUI() {
        self.nvcHome = UINavigationController.init(rootViewController: Utilities.share.createVCwith(nameStoryboard.nameSB, nameVC.HomeVC))
        self.nvcFeature = UINavigationController.init(rootViewController: Utilities.share.createVCwith(nameStoryboard.nameSB, nameVC.FeatureVC))
        self.nvcUser = UINavigationController.init(rootViewController: Utilities.share.createVCwith(nameStoryboard.nameSB, nameVC.UserVC))
        self.nvcSetting = UINavigationController.init(rootViewController: Utilities.share.createVCwith(nameStoryboard.nameSB, nameVC.SettingVC))
    }
    
    func addSubView(_ nvcViewShow: UINavigationController,_ nvcViewHide1: UINavigationController,_ nvcViewHide2: UINavigationController,_ nvcViewHide3: UINavigationController){
        nvcViewShow.view.frame = self.vContainer.bounds
        for view in self.vContainer.subviews {
            if (view == nvcViewHide1.view || view == nvcViewHide2 || view == nvcViewHide3 ){
                view.removeFromSuperview()
                break
            }
        }
        self.vContainer.addSubview(nvcViewShow.view)
        nvcViewShow.view.bringSubviewToFront(self.vContainer)
    }
    func changeBackgroundButton(_ imgBtnHome:String,_ imgBtnFeature:String,_ imgBtnUser:String,_ imgBtnSetting:String){
        self.vNavigation.btnHome.setBackgroundImage(UIImage.init(named: imgBtnHome), for: .normal)
        self.vNavigation.btnFeature.setBackgroundImage(UIImage.init(named: imgBtnFeature), for: .normal)
        self.vNavigation.btnUser.setBackgroundImage(UIImage.init(named: imgBtnUser), for: .normal)
        self.vNavigation.btnSetting.setBackgroundImage(UIImage.init(named: imgBtnSetting), for: .normal)
    }
}
