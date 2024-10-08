//
//  OffersEntity.swift
//  VIperExample
//
//  Created by Diego on 8/10/24.
//

import Foundation

struct OffersEntity: Decodable {
    var title: String
    var offers: [Offers]
}

struct Offers: Decodable {
    var icon: String
    var title: String
    var description: String
}

