//
//  HomeVC.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 9/25/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class HomeVC: UIViewController,BaseFeatureDelegate {
    
    @IBOutlet weak var vlogo: UIImageView!
    @IBOutlet weak var vIndoor: BaseWeather!
    @IBOutlet weak var vOutdoor: BaseWeather!
    @IBOutlet weak var lblIndoor: UILabel!
    @IBOutlet weak var lblOutdoor: UILabel!
    @IBOutlet weak var btnDoor: UIButton!
    @IBOutlet weak var btnSecurity: UIButton!
    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var vDoor: BaseFeature!
    @IBOutlet weak var vSecurity: BaseFeature!
    
    var delegate = UIApplication.shared.delegate as! AppDelegate
    var security :Bool!
    var door: Bool!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setWeatherInUI()
        self.navigationController?.isNavigationBarHidden = true
        self.vDoor.delegate = self
        self.vSecurity.delegate = self
        SocketIOManager.shared.socket!.on("home-update") { data, ack in
            var value = JSON(data)
            do{
                value = value[0]
                let home = try JSONDecoder().decode(HomeModal.self, from: value["home"].rawData())
                self.delegate.home = home
                self.setview()
            }
            catch{
                print("err")
            }
        }
        self.setview()
    }
    
    //MARK: - BaseFeatureDelegate
    func click(Button: UIButton, view: UIView) {
        if (view == vDoor)
        {
            if(self.door){
                self.door = false
                self.delegate.home!.door.status = door
                self.vDoor.img.image = UIImage.init(named: "open-door")
                self.vDoor.lblStatus.text = "Open"
            }
            else
            {
                self.door = true
                self.delegate.home!.door.status = door
                self.vDoor.img.image = UIImage.init(named: "closed-door")
                self.vDoor.lblStatus.text = "Close"
            }
            self.onServer()
            let dataSend = ["status":self.door]
            SocketIOManager.shared.emidServer("door", [dataSend])
        }
        else if(view == vSecurity){
            if(self.security){
                self.security = false
                self.delegate.home!.security.status = door
//                self.vSecurity.img.image = UIImage.init(named: "unlock")
//                self.vSecurity.lblStatus.text = "Off"
            }
            else
            {
                self.security = true
                self.delegate.home!.security.status = security
//                self.vSecurity.img.image = UIImage.init(named: "locked")
//                self.vSecurity.lblStatus.text = "On"
             }
            self.onServer()
            let dataSend = ["status":self.security]
            SocketIOManager.shared.emidServer("security", [dataSend])
        }
    }
    
    func setview(){
        self.vIndoor.layer.cornerRadius = 20
        self.vOutdoor.layer.cornerRadius = 20
        self.vContainer.layer.cornerRadius = 20
        self.vDoor.layer.cornerRadius = 20
        self.vSecurity.layer.cornerRadius = 20
        self.door = delegate.home!.door.status
        self.security = delegate.home!.security.status
        self.vIndoor.img.image = UIImage.init(named: "indoor")
        self.vIndoor.lblTemp.text = "\(self.delegate.home!.parameter.temperature) C"
        self.vIndoor.lblHumidity.text = "\(self.delegate.home!.parameter.humidity) %"
        if(self.delegate.home!.parameter.temperature.isLess(than: 28.0) == false){
            self.vIndoor.lblWeather.text = "Hot!Your need to turn on the air conditioner."
        }
        else if(self.delegate.home!.parameter.temperature.isLess(than: 25.0)){
            self.vIndoor.lblWeather.text = "Cold!Your need to turn on the air conditioner."
        }
        else{
             self.vIndoor.lblWeather.text = "Suitable temperature!"
        }
        
        self.vDoor.lblInfo.text = "Door"
        self.vSecurity.lblInfo.text = "Security"
        if(self.door){
            self.vDoor.img.image = UIImage.init(named: "open-door")
            self.vDoor.lblStatus.text = "Open"
        }
        else
        {
            self.vDoor.img.image = UIImage.init(named: "closed-door")
            self.vDoor.lblStatus.text = "Close"
        }
        
        if(self.security){
            self.vSecurity.img.image = UIImage.init(named: "locked")
            self.vSecurity.lblStatus.text = "On"
        }
        else
        {
            self.vSecurity.img.image = UIImage.init(named: "unlock")
            self.vSecurity.lblStatus.text = "Off"
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
                case 8:
                    self.delegate.home?.security.status = st!
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
    
    //MARK: - call api weather
    func setWeatherInUI(){
        let location = LocationModal.init(10.773743, 106.698792)
        SVProgressHUD.show()
        self.sentGetRequese(["appid":"39486e1bae1d60fd7644da208305435e","lat":"\(location.latitude!)","lon":"\(location.longitude!)"]){
            (error, weather) in
        SVProgressHUD.dismiss()
            if error == ""{
                self.vOutdoor.lblWeather.text = weather!.weather.description
                self.vOutdoor.img.image = UIImage.init(named: weather!.weather.icon)
                let tempC = Int(weather!.main.temp - 273.15)
                self.vOutdoor.lblTemp.text = "Temp: \(tempC) C"
                self.vOutdoor.lblHumidity.text = "Humidity: \(weather!.main.humidity) %"
            }else{
                print(error)
            }
        }
    }
    func sentGetRequese(_ params: [String: Any],complete: @escaping(String, DataWeatherModal?) -> Void){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather")  else {
            return
        }
        Alamofire.request(url, method: .get, parameters: params, headers: nil).responseJSON { (response) in
            guard response.result.isSuccess,let value = response.result.value else{
                print("ERROR: \(String(describing: response.result.error))")
                complete(String(describing: response.result.error), nil)
                return
            }
            let data = JSON(value)
            do{
                var weather = DataWeatherModal.init()
                let main = try JSONDecoder().decode(MainWeatherModal.self, from: data["main"].rawData())
                let infoWeather = try JSONDecoder().decode(WeatherModal.self, from: data["weather"][0].rawData())
                weather.main = main
                weather.weather = infoWeather
                complete("",weather)
            }
            catch let err{
                complete(err.localizedDescription, nil)
            }
        }
    }
    
}
