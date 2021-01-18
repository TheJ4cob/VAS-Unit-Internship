//
//  PromotionsParser.swift
//  VASUnitInternship
//
//  Created by Никита on 08.01.2021.
//

import UIKit


// Decode data from
class PromotionsParser: PromotionParserProtocol {
    
    // MARK: -  PromotionParser Protocol Realization
    
    func parseData(from data: Data) -> Promotions? {
        
        do {
            
            let promotionData = try JSONDecoder().decode(PromotionsData.self, from: data)
            if promotionData.status == "ok" {
            return promotionData.result
                
            }
            
        } catch {
            
            print(error)
        }
        
        return nil
        
    }
    
}
