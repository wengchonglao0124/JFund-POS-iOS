//
//  PromotionCustomerView.swift
//  Jacaranda Card POS
//
//  Created by weng chong lao on 27/11/2022.
//

import SwiftUI

struct PromotionCustomerView: View {
    
    var companyName: String
    var promotionStatus: PromotionStatus
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var title: String
    var description: String
    
    @State var isLoading = false
    @State var isPresentingSuccessContent = false
    @State var finishedAction = false
    
    // for active status only
    @State var isConfirmingCancel = false
    @State var confirmedCancel = false
    
    var endDate: Date
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 0) {
                        // MARK: Company Image Section
                        Image("companyImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 320, height: 218)
                            .clipped()
                            .cornerRadius(12)
                            .padding(.top, 22)
                            .padding(.bottom, 24)
                        
                        // MARK: Title Section
                        VStack {
                            VStack(alignment: .leading, spacing: 13) {
                                HStack {
                                    Text(title)
                                        .font(Font.custom("DMSans-Bold", size: 16))
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                
                                Text(companyName)
                                    .font(Font.custom("DMSans-Medium", size: 14))
                                    .foregroundColor(Color(red: 122/255, green: 126/255, blue: 128/255))
                            }
                            .padding(.top, 18)
                            .padding(.bottom, 16)
                            .padding(.horizontal, 21)
                        }
                        .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                        .cornerRadius(12)
                        .padding(.bottom, 22)
                        
                        // MARK: Expired Date Section
                        VStack {
                            HStack {
                                VStack(alignment: .leading, spacing: 11) {
                                    Text("Expiry date")
                                        .font(Font.custom("DMSans-Bold", size: 12))
                                        .foregroundColor(Color(red: 122/255, green: 126/255, blue: 128/255))
                                    
                                    Text(DateService.getDateString(format: "dd/MM/yyyy", date: endDate))
                                        .font(Font.custom("DMSans-Medium", size: 14))
                                        .foregroundColor(.black)
                                }
                                Spacer()
                            }
                            .padding(.top, 18)
                            .padding(.bottom, 21)
                            .padding(.leading, 21)
                        }
                        .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                        .cornerRadius(12)
                        .padding(.bottom, 22)
                        
                        // MARK: Description Section
                        VStack {
                            VStack(alignment: .leading, spacing: 11) {
                                Text("Description")
                                    .font(Font.custom("DMSans-Bold", size: 12))
                                    .foregroundColor(Color(red: 137/255, green: 138/255, blue: 141/255))
                                
                                HStack {
                                    Text(description)
                                        .font(Font.custom("DMSans-Medium", size: 12))
                                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 30/255))
                                    Spacer()
                                }
                            }
                            .padding(.top, 18)
                            .padding(.bottom, 21)
                            .padding(.leading, 21)
                            .padding(.trailing, 18)
                        }
                        .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                        .cornerRadius(12)
                        .padding(.bottom, 22)
                        
                        // MARK: Cancel Promotion Button
                        if promotionStatus == .active {
                            Button {
                                print("Cancel Promotion")
                                isConfirmingCancel = true
                            } label: {
                                Image("promotionCancelButton")
                            }
                            .disabled(isLoading)
                        }
                        Spacer()
                    }
                    .frame(width: 320)
                    Spacer()
                }
            }
            
            // MARK: Confirm Delete Section
            ConfirmMessageView(message: "Are you sure to cancel promotion ?", isPresenting: $isConfirmingCancel, isAgree: $confirmedCancel)
            
            // MARK: Loading Section
            LoadingView(message: "Loading", isLoading: $isLoading, isFinished: $isPresentingSuccessContent)
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image("backArrowBlack")
                .padding(0)
        })
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
        }))
        .sheet(isPresented: $isPresentingSuccessContent) {
            SuccessContentView(message: "Promotion has been cancelled", subtitle: "", isPresenting: $isPresentingSuccessContent, finishedProcess: $finishedAction)
        }
        .onChange(of: finishedAction) { newValue in
            self.mode.wrappedValue.dismiss()
        }
        .onChange(of: confirmedCancel) { newValue in
            isLoading = true
        }
    }
}

struct PromotionCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                PromotionCustomerView(companyName: "Pizza Hut", promotionStatus: .active, title: "Hawaiian Pizza & Ice cream 10% off in Valentines day ", description: "Pizza Hut Hawaiian Pizza & Ice cream 10% off in 14/02 Valentines day (not avaliable with any other deals)\n\nOnly in Valentines day!! ", endDate: Date())
            }
            
            NavigationView {
                PromotionCustomerView(companyName: "Pizza Hut", promotionStatus: .expired, title: "Hawaiian Pizza & Ice cream 10% off in Valentines day", description: "Pizza Hut Hawaiian Pizza & Ice cream 10% off in 14/02 Valentines day (not avaliable with any other deals)\n\nOnly in Valentines day!!", endDate: Date())
            }
            
            NavigationView {
                PromotionCustomerView(companyName: "Pizza Hut", promotionStatus: .active, title: "Hawaiian Pizza & Ice cream 10% off in Valentines day", description: "Pizza Hut Hawaiian Pizza & Ice cream 10% off in 14/02 Valentines day (not avaliable with any other deals)\n\nOnly in Valentines day!!", endDate: Date())
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}
