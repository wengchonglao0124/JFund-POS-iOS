//
//  PromotionDataService.swift
//  Jacaranda Card POS
//
//  Created by weng chong lao on 25/11/2022.
//

import Foundation

class PromotionDataService {
    
    static func getLocalData() -> [Promotion] {
        
        // Parse local json file
        let pathString = Bundle.main.path(forResource: "promotions", ofType: "json")
        
        // Check if pathString is not nil, otherwise...
        guard pathString != nil else {
            return [Promotion]()
        }
        
        // Get a url path to the json file
        let url = URL(fileURLWithPath: pathString!)
        
        do {
            // Create a url object
            let data = try Data(contentsOf: url)
            
            // Create a data obect
            let decoder = JSONDecoder()
            
            do {
                // Decode the data with a JSON decoder
                let promotionData = try decoder.decode([Promotion].self, from: data)
                
                // Add a unique ID
                for promotion in promotionData {
                    promotion.id = UUID()
                }
                
                // Return the recipes
                return promotionData
            }
            catch {
                // error with parsing json
                print(error)
            }
        }
        catch {
            // error with getting data
            print(error)
        }
        
        // if getting some errors above
        return [Promotion]()
    }
}
