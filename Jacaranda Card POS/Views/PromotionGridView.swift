//
//  PromotionGridView.swift
//  Jacaranda Card POS
//
//  Created by weng chong lao on 24/11/2022.
//

import SwiftUI

struct PromotionGridView: View {
    
    @State var promotions: [Promotion]
    private var promotionsSorted: [Promotion] {
        promotions.sorted(by: { $0.startDate.compare($1.startDate) == .orderedDescending })
    }
    var filter: String
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        if promotions.isEmpty {
            HStack {
                Spacer()
                VStack {
                    Image("noPromotionImage")
                        .padding(.top, 49)
                        .padding(.bottom, 26)
                    Text("No promotional content yet")
                        .font(Font.custom("DMSans-Bold", size: 14))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 30/255))
                    Spacer()
                }
                Spacer()
            }
        }
        else {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 18) {
                    ForEach(promotionsSorted, id: \.id) { promotion in
                        if filter == "all" {
                            ListPromotionView(promotion: promotion)
                        }
                        else {
                            if filter == promotion.status {
                                ListPromotionView(promotion: promotion)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 31)
        }
    }
}

struct PromotionGridView_Previews: PreviewProvider {
    static var previews: some View {
        
        let promotionModel = PromotionModel()
        
        Group {
            PromotionGridView(promotions: [Promotion](), filter: "all")
                .previewLayout(.sizeThatFits)
            
            PromotionGridView(promotions: promotionModel.promotions, filter: "all")
            
            PromotionGridView(promotions: promotionModel.promotions, filter: "active")
            
            PromotionGridView(promotions: promotionModel.promotions, filter: "pending")
            
            PromotionGridView(promotions: promotionModel.promotions, filter: "expired")
            
            PromotionGridView(promotions: promotionModel.promotions, filter: "all")
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}
