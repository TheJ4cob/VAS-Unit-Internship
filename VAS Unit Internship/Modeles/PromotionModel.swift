//
//  PromotionModel.swift
//  VASUnitInternship
//
//  Created by Никита on 08.01.2021.
//

import Foundation

struct PromotionsData: Codable {
    var status: String
    var result: Promotions
}

struct Promotions: Codable {
    var title: String
    var actionTitle: String
    var selectedActionTitle: String
    var promotions: [Promotion]
    
    enum CodingKeys: String, CodingKey {
        case title
        case actionTitle
        case selectedActionTitle
        case promotions = "list"
    }
}

class Promotion: Codable {
    var id: String
    var title: String
    var description: String?
    var icon: PromotionIcon
    var price: String
    var isSelected: Bool
}

struct PromotionIcon: Codable {
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "52x52"
    }
}
