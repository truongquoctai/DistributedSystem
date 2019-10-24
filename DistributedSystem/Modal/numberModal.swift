//
//  numberModal.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 10/13/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import Foundation

struct numberModal: Codable {
    var num: Int
    
    init(_ num: Int) {
        self.num = num
    }
}
