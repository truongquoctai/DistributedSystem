//
//  HomeModal.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 10/6/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import Foundation
struct livingModal:Codable {
    var statusLight: Bool
    var fan: Bool
    init(_ statusLight: Bool,_ fan: Bool) {
        self.fan = fan
        self.statusLight = statusLight
    }
}
struct kitchenModal:Codable {
    var statusLight: Bool
    init(_ statusLight: Bool) {
        self.statusLight = statusLight
    }
}
struct bathModal:Codable {
    var statusLight:Bool
    init(_ statusLight: Bool) {
        self.statusLight = statusLight
    }
}

struct bedModal: Codable {
    var statusLightMain:Bool
    var statusLightExtra:Bool
    init(_ statusLightMain:Bool,_ statusLightExtra:Bool) {
        self.statusLightMain = statusLightMain
        self.statusLightExtra = statusLightExtra
    }
}
struct parameterModal:Codable {
    var temperature: Double
    var humidity: Double
    init(_ temperature: Double,_ humidity: Double) {
        self.temperature = temperature
        self.humidity = humidity
    }
}
struct doorModal: Codable {
    var status: Bool
    init(_ status: Bool) {
        self.status = status
    }
}
struct securityModal: Codable {
    var status: Bool
    init(_ status: Bool) {
        self.status = status
    }
}



struct HomeModal:Codable {
    var living: livingModal
    var kitchen: kitchenModal
    var bath: bathModal
    var bed: bedModal
    var parameter:parameterModal
    var door: doorModal
    var security: securityModal
    init(_ living: livingModal,_ kitchen: kitchenModal,_ bath: bathModal,_ bed: bedModal,_ parameter:parameterModal,_ door: doorModal,_ security: securityModal) {
        self.living = living
        self.kitchen = kitchen
        self.bed = bed
        self.bath = bath
        self.parameter = parameter
        self.door = door
        self.security = security
    }
}
