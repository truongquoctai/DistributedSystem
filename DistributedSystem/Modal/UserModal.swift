//
//  UserModal.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 9/27/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import Foundation

struct UserModal:Codable {
    var username:String
    var password:String
    var fullname:String
    
    init(_ username:String,_ password:String,_ fullname:String) {
        self.username = username
        self.password = password
        self.fullname = fullname
    }
    
}
