//
//  AminModal.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 9/27/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import Foundation

struct AdminModal:Codable {
    var username: String
    var password:String
    var fullname:String
    var phone:String
    var email:String
    init(_ username: String,_ password:String,_ fullName:String,_ phone:String,_ email:String) {
        self.username = username
        self.password = password
        self.fullname = fullName
        self.phone = phone
        self.email = email
    }
    init() {
        self.username = "username"
        self.password = "password"
        self.fullname = "fullName"
        self.phone = "phone"
        self.email = "email"
    }
}
