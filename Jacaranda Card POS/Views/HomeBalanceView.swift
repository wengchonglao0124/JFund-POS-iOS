//
//  HomeBalanceView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import SwiftUI

struct HomeBalanceView: View {
    
    @State var balance: String
    var carID: String
    
    var body: some View {
        
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 25) {
                Text("Balace")
                    .foregroundColor(Color("balanceSectionColor"))
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                
                Label(balance, image: "balance")
                    .foregroundColor(Color("balanceColor"))
                    .font(.system(size: 18).bold())
    
            }
            Spacer()
            Text(carID)
                .foregroundColor(Color("balanceSectionIDColor"))
                .font(.system(size: 14))
                .fontWeight(.bold)
        }
        .padding(.top, 15)
        .padding(.bottom, 25)
        .padding(.leading, 27)
        .padding(.trailing, 13)
        .background(.white)
    }
}

struct HomeBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBalanceView(balance: "0.00", carID: "1234 5678 3657 5623")
            .previewLayout(.sizeThatFits)
    }
}
