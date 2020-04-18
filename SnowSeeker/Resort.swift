//
//  Resort.swift
//  SnowSeeker
//
//  Created by dominator on 17/04/20.
//  Copyright © 2020 dominator. All rights reserved.
//

import Foundation
struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    var facitilyTypes: [Facility]{
       facilities.map(Facility.init)
    }
}
extension Resort{
    static let example: Resort = (Bundle.main.decode("resorts.json") as [Resort])[0]
}
