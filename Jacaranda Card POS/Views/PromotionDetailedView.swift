//
//  PromotionDetailedView.swift
//  Jacaranda Card POS
//
//  Created by weng chong lao on 26/11/2022.
//

import SwiftUI

struct PromotionDetailedView: View {
    
    // default status
    var promotionStatus: PromotionStatus = PromotionStatus.request
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    @State var title: String
    @FocusState private var titleKeyboardFocused: Bool
    @State var description: String
    @FocusState private var descriptionKeyboardFocused: Bool
    
    @State var isLoading = false
    @State var isPresentingSuccessContent = false
    @State var finishedAction = false
    
    // for pending status only
    @State var isConfirmingDelete = false
    @State var confirmedDelete = false
    
    // from tomorrow
    var pickerStartDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    @State var startDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    @State var endDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    // MARK: Title Section
                    Text("Title")
                        .font(Font.custom("DMSans-Medium", size: 14))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 30/255))
                        .padding(.top, 37)
                        .padding(.bottom, 8)
                    
                    // MARK: Title Input Section
                    VStack {
                        TextField("", text: $title)
                            .limitInputTextLength(value: $title, length: 45)
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .foregroundColor(.black)
                            .frame(width: 294, height: 20)
                            .padding(.vertical, 12)
                            .padding(.leading, 12)
                            .padding(.trailing, 15)
                            .keyboardType(.default)
                            .focused($titleKeyboardFocused)
                            .disabled(isLoading)
                    }
                    .background(Color(red: 237/255, green: 238/255, blue: 240/255))
                    .cornerRadius(5)
                    .padding(.bottom, 20)
                    
                    // MARK: Promotion Period Section
                    Text("Promotion period")
                        .font(Font.custom("DMSans-Medium", size: 14))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 30/255))
                        .padding(.bottom, 8)
                    
                    // MARK: Promotion Period Date Picker Section
                    HStack(alignment: .center, spacing: 19) {
                        DatePicker("", selection: $startDate, in: pickerStartDate..., displayedComponents: .date)
                            .labelsHidden()
                            .transformEffect(.init(scaleX: 0.75, y: 0.75))
                            .disabled(isLoading)
                        
                        Text("to")
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .foregroundColor(Color(red: 30/255, green: 30/255, blue: 30/255))
                            .padding(.trailing, 30)
                        
                        DatePicker("", selection: $endDate, in: startDate..., displayedComponents: .date)
                            .labelsHidden()
                            .transformEffect(.init(scaleX: 0.75, y: 0.75))
                            .disabled(isLoading)
                    }
                    .padding(.bottom, 18)
                    
                    // MARK: Description Section
                    Text("Description")
                        .font(Font.custom("DMSans-Medium", size: 14))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 30/255))
                        .padding(.bottom, 8)
                    
                    // MARK: Description Input Section
                    VStack {
                        TextEditor(text: $description)
                        //.limitInputLength(value: $title, length: 45)
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .foregroundColor(.black)
                            .colorMultiply(Color(red: 237/255, green: 238/255, blue: 240/255))
                            .frame(width: 290, height: 120)
                            .padding(.top, 13)
                            .padding(.bottom, 11)
                            .padding(.leading, 12)
                            .padding(.trailing, 28)
                            .keyboardType(.default)
                            .focused($descriptionKeyboardFocused)
                            .disabled(isLoading)
                    }
                    .background(Color(red: 237/255, green: 238/255, blue: 240/255))
                    .cornerRadius(5)
                    .padding(.bottom, 18)
                    
                    // MARK: Confirm Section
                    switch promotionStatus {
                    case .pending:
                        // for pending status
                        HStack(spacing: 20) {
                            Button {
                                print("Promotion Delete")
                                isConfirmingDelete = true
                            } label: {
                                Image("promotionDeleteButton")
                            }
                            .disabled(isLoading)

                            Button {
                                print("Promotion Resubmit")
                                isLoading = true
                            } label: {
                                if title.isEmpty || description.isEmpty {
                                    Image("promotionResubmitButtonInactive")
                                }
                                else {
                                    Image("promotionResubmitButton")
                                }
                            }
                            .disabled(title.isEmpty || description.isEmpty || isLoading)
                        }
                    default:
                        // Request promotion
                        Button {
                            // Submit
                            isLoading = true
                        } label: {
                            if title.isEmpty || description.isEmpty {
                                Image("promotionConfirmButtonInactive")
                            }
                            else {
                                Image("promotionConfirmButtonActive")
                            }
                        }
                        .disabled(title.isEmpty || description.isEmpty || isLoading)
                    }
                    Spacer()
                }
                Spacer()
            }
            // MARK: Confirm Delete Section
            ConfirmMessageView(message: "Are you sure to delete content ?", isPresenting: $isConfirmingDelete, isAgree: $confirmedDelete)
            
            // MARK: Loading Section
            LoadingView(message: "Loading", isLoading: $isLoading, isFinished: $isPresentingSuccessContent)
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Edit content")
                        .font(Font.custom("DMSans-Bold", size: 16))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image("backArrowBlack")
                .padding(0)
        })
        .onTapGesture {
            titleKeyboardFocused = false
            descriptionKeyboardFocused = false
        }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
        }))
        .sheet(isPresented: $isPresentingSuccessContent) {
            switch promotionStatus {
            case .pending:
                if !confirmedDelete {
                    SuccessContentView(message: "Content has been resubmitted", subtitle: "Your content will be reviewed by the admin which takes up to 1-2 business day", isPresenting: $isPresentingSuccessContent, finishedProcess: $finishedAction)
                }
                else {
                    SuccessContentView(message: "Content has been Deleted", subtitle: "", isPresenting: $isPresentingSuccessContent, finishedProcess: $finishedAction)
                }
                
            default:
                SuccessContentView(message: "Content submitted", subtitle: "Your content will be reviewed by the admin which takes up to 24 hours", isPresenting: $isPresentingSuccessContent, finishedProcess: $finishedAction)
            }
        }
        .onChange(of: finishedAction) { newValue in
            self.mode.wrappedValue.dismiss()
        }
        .onChange(of: confirmedDelete) { newValue in
            isLoading = true
        }
    }
}

struct PromotionDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                PromotionDetailedView(title: "", description: "")
            }
            
            NavigationView {
                PromotionDetailedView(title: "Hawaiian Pizza & Ice cream 10% off in Valenti", description: "Pizza Hut Hawaiian Pizza & Ice cream 10% off in 14/02 Valentines day (not avaliable with any other deals) \n\nOnly in Valentines day!!")
            }
            
            NavigationView {
                PromotionDetailedView(promotionStatus: .pending, title: "Hawaiian Pizza & Ice cream 10% off in Valenti", description: "Pizza Hut Hawaiian Pizza & Ice cream 10% off in 14/02 Valentines day (not avaliable with any other deals) \n\nOnly in Valentines day!!")
            }
            
            NavigationView {
                PromotionDetailedView(promotionStatus: .pending, title: "Hawaiian Pizza & Ice cream 10% off in Valenti", description: "Pizza Hut Hawaiian Pizza & Ice cream 10% off in 14/02 Valentines day (not avaliable with any other deals) \n\nOnly in Valentines day!!")
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            
            NavigationView {
                PromotionDetailedView(promotionStatus: .pending, title: "Hawaiian Pizza & Ice cream 10% off in Valenti", description: "")
            }
            
            NavigationView {
                PromotionDetailedView(title: "", description: "")
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            
            NavigationView {
                PromotionDetailedView(title: "Hawaiian Pizza & Ice cream 10% off in Valenti", description: "Pizza Hut Hawaiian Pizza & Ice cream 10% off in 14/02 Valentines day (not avaliable with any other deals) \n\nOnly in Valentines day!!")
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}
