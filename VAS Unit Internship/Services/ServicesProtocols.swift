//
//  ServicesProtocols.swift
//  VASUnitInternship
//
//  Created by Никита on 08.01.2021.
//

import Foundation

protocol LoadDataProtocol {
    func loadData(from source: String, complition: @escaping (_ data: Data?) -> Void)
}

protocol PromotionParserProtocol {
    func parseData(from data: Data) -> Promotions?
}
