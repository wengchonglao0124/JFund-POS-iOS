//
//  ListPromotionView.swift
//  Jacaranda Card POS
//
//  Created by weng chong lao on 25/11/2022.
//

import SwiftUI

struct ListPromotionView: View {
    
    var promotion: Promotion
    
    var body: some View {
        
        NavigationLink(destination: {
            
            switch promotion.status {
            case "active":
                // active
                PromotionCustomerView(companyName: "Pizza Hut", promotionStatus: .active, title: promotion.title, description: promotion.description, endDate: promotion.endDate)
                
            case "pending":
                // pending
                PromotionDetailedView(promotionStatus: .pending, title: promotion.title, description: promotion.description, startDate: promotion.startDate, endDate: promotion.endDate)
                
            default:
                // expired
                PromotionCustomerView(companyName: "Pizza Hut", promotionStatus: .expired, title: promotion.title, description: promotion.description, endDate: promotion.endDate)
            }
        }) {
            VStack(alignment: .center, spacing: 0) {
                // MARK: Company Image Section
                Image("companyImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 100)
                    .clipped()
                
                // MARK: Title Section
                HStack {
                    Text(TextService.getStringByLength(text: promotion.title, length: 34))
                        .font(Font.custom("DMSans-Bold", size: 12))
                        .frame(height: 34)
                        .foregroundColor(.black)
                        .padding(.top, 10)
                        .padding(.bottom, 11)
                        .multilineTextAlignment(.leading)
                        
                    Spacer()
                }
                .padding(.leading, 9)
                
                HStack(alignment: .bottom, spacing: 38) {
                    // MARK: Status Section
                    if promotion.status == "active" {
                        Image("active")
                    }
                    else if promotion.status == "pending" {
                        Image("pending")
                    }
                    else {
                        Image("expired")
                    }
                    
                    // MARK: Start Date Section
                    Text(DateService.getDateString(format: "dd-MM-yyyy", date: promotion.startDate))
                        .font(Font.custom("DMSans-Medium", size: 8))
                        .foregroundColor(Color(red: 122/255, green: 126/255, blue: 128/255))
                }
                .padding(.bottom, 10)
            }
        }
        .frame(width: 150, height: 180)
        .background(Color(red: 252/255, green: 252/255, blue: 252/255))
        .cornerRadius(12)
        .shadow(color: Color(red: 151/255, green: 151/255, blue: 151/255, opacity: 0.2), radius: 4, x: 2, y: 2)
    }
}

struct ListPromotionView_Previews: PreviewProvider {
    static var previews: some View {
        
        let promotionModel = PromotionModel()
        Group {
            ListPromotionView(promotion: promotionModel.promotions[0])
                .previewLayout(.sizeThatFits)
            
            ListPromotionView(promotion: promotionModel.promotions[4])
                .previewLayout(.sizeThatFits)
            
            ListPromotionView(promotion: promotionModel.promotions[5])
                .previewLayout(.sizeThatFits)
        }
    }
}
