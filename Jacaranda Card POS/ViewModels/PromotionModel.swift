//
//  PromotionModel.swift
//  Jacaranda Card POS
//
//  Created by weng chong lao on 25/11/2022.
//

import Foundation

class PromotionModel: ObservableObject {
    
    @Published var promotions = [Promotion]()
    
    init() {
        self.promotions = PromotionDataService.getLocalData()
    }
}
