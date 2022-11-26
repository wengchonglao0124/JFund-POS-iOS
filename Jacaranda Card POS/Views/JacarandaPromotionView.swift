//
//  JacarandaPromotionView.swift
//  Jacaranda Card POS
//
//  Created by weng chong lao on 23/11/2022.
//

import SwiftUI

struct JacarandaPromotionView: View {
    
    @State var selectedTab = "all"
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // MARK: Title Section
            HStack(spacing: 0) {
                Text("Promotion")
                    .font(Font.custom("DMSans-Bold", size: 18))
                    .padding(.leading, 22)
                    .padding(.bottom, 33)
                Spacer()
            }
            
            // MARK: Request Promotion Section
            NavigationLink(destination: PromotionDetailedView(title: "", description: "")) {
                Image("requestPromotionButton")
            }

            // MARK: Picker Section
            HStack(alignment: .center, spacing: 25) {
                // MARK: All Tab
                Text("All")
                    .font(Font.custom("DMSans-Bold", size: 12))
                    .foregroundColor({
                        if selectedTab == "all" {
                            return Color("promotionPickerSelectedColor")
                        }
                        else {
                            return Color("promotionPickerColor")
                        }
                    }())
                    .underline(selectedTab == "all")
                    .onTapGesture {
                        withAnimation(.interactiveSpring(
                            response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                selectedTab = "all"
                            }
                    }
                
                // MARK: Active Tab
                Text("Active")
                    .font(Font.custom("DMSans-Bold", size: 12))
                    .foregroundColor({
                        if selectedTab == "active" {
                            return Color("promotionPickerSelectedColor")
                        }
                        else {
                            return Color("promotionPickerColor")
                        }
                    }())
                    .underline(selectedTab == "active")
                    .onTapGesture {
                        withAnimation(.interactiveSpring(
                            response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                selectedTab = "active"
                            }
                    }
                
                // MARK: Pending Tab
                Text("Pending")
                    .font(Font.custom("DMSans-Bold", size: 12))
                    .foregroundColor({
                        if selectedTab == "pending" {
                            return Color("promotionPickerSelectedColor")
                        }
                        else {
                            return Color("promotionPickerColor")
                        }
                    }())
                    .underline(selectedTab == "pending")
                    .onTapGesture {
                        withAnimation(.interactiveSpring(
                            response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                selectedTab = "pending"
                            }
                    }
                
                // MARK: Expired Tab
                Text("Expired")
                    .font(Font.custom("DMSans-Bold", size: 12))
                    .foregroundColor({
                        if selectedTab == "expired" {
                            return Color("promotionPickerSelectedColor")
                        }
                        else {
                            return Color("promotionPickerColor")
                        }
                    }())
                    .underline(selectedTab == "expired")
                    .onTapGesture {
                        withAnimation(.interactiveSpring(
                            response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                selectedTab = "expired"
                            }
                    }
                
                Spacer()
            }
            .padding(.leading, 33)
            .padding(.vertical, 28)
            
            // MARK: Promotion Grid Section
            let promotionModel = PromotionModel()
            PromotionGridView(promotions: promotionModel.promotions, filter: selectedTab)
        }
    }
}

struct JacarandaPromotionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                JacarandaPromotionView()
            }
            
            NavigationView {
                JacarandaPromotionView()
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}
