//
//  FeatureVC.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 9/25/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit

class FeatureVC: UIViewController {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var btnLiving: UIButton!
    @IBOutlet weak var btnKitchen: UIButton!
    @IBOutlet weak var btnBedroom: UIButton!
    @IBOutlet weak var btnBath: UIButton!
    @IBAction func onBtnLiving(_ sender: Any) {
        btnLiving.titleLabel!.font = UIFont.boldSystemFont(ofSize: 22)
        btnKitchen.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        btnBath.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        btnBedroom.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        self.addSubView(nvcLiving, nvcKitchen, nvcBed, nvcBath)
    }
    @IBAction func onBtnKitchen(_ sender: Any) {
        btnKitchen.titleLabel!.font = UIFont.boldSystemFont(ofSize: 22)
        btnLiving.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        btnBath.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        btnBedroom.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        self.addSubView(nvcKitchen, nvcLiving, nvcBed, nvcBath)
    }
    @IBAction func onBtnbedroom(_ sender: Any) {
        btnBedroom.titleLabel!.font = UIFont.boldSystemFont(ofSize: 22)
        btnLiving.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        btnBath.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        btnKitchen.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        self.addSubView(nvcBed, nvcKitchen, nvcLiving, nvcBath)
    }
    @IBAction func onBtnBathroom(_ sender: Any) {
        btnBath.titleLabel!.font = UIFont.boldSystemFont(ofSize: 22)
        btnKitchen.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        btnLiving.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        btnBedroom.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        self.addSubView(nvcBath, nvcKitchen, nvcBed, nvcLiving)
    }
    @IBOutlet weak var vContainer: UIView!
    var nvcLiving: UINavigationController!
    var nvcKitchen: UINavigationController!
    var nvcBed: UINavigationController!
    var nvcBath: UINavigationController!
    var door = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.addSubView(nvcLiving, nvcKitchen, nvcBed, nvcBath)
        btnLiving.titleLabel!.font = UIFont.boldSystemFont(ofSize: 22)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func initUI() {
        self.nvcLiving = UINavigationController.init(rootViewController:
            Utilities.share.createVCwith(nameStoryboard.nameSB, nameVC.LivingVC))
        self.nvcKitchen = UINavigationController.init(rootViewController: Utilities.share.createVCwith(nameStoryboard.nameSB, nameVC.KitchenVC))
        self.nvcBed = UINavigationController.init(rootViewController: Utilities.share.createVCwith(nameStoryboard.nameSB, nameVC.BedroomVC))
        self.nvcBath = UINavigationController.init(rootViewController: Utilities.share.createVCwith(nameStoryboard.nameSB, nameVC.BathroomVC))
        self.door = self.delegate.home!.door.status
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
}
