//
//  ScanPaymentView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 30/10/2022.
//

import SwiftUI
import CodeScanner

struct ScanPaymentView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    @State var isPresentingScanner = false
    @State var scannedCode: String = ""
    
    @State var paymentAmount = ""
    
    @State var isPresentingConfirmPayment = false
    @State var isLoading = false
    @State var isPresentingSuccesseReceive = false
    @State var finishedReceive = false
    
    @FocusState private var keyboardFocused: Bool
    
    var scannerSheet: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.isPresentingScanner = false
                    
                    isLoading = true
                }
            }
        )
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                
                // MARK: Payment Amount Section
                VStack(alignment: .leading, spacing: 11) {
                    Text("Enter the amount")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 172/255, green: 172/255, blue: 176/255))
                        .padding(.top, 15)
                        .padding(.leading, 30)
          
                    HStack(spacing: 0) {
                        Text("$")
                            .font(.system(size: 24))
                            .fontWeight(.medium)
                            .foregroundColor(Color(red: 30/255, green: 30/255, blue: 30/255))
                            .padding(.bottom, 16)
                            .padding(.leading, 30)
                        
                        TextField("0.00", text: $paymentAmount)
                            .modifyInputCurrency(value: $paymentAmount)
                            .font(.system(size: 24))
                            .font(.title.weight(.medium))
                            .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                            .padding(.bottom, 16)
                            .padding(.leading, 12)
                            .keyboardType(.numberPad)
                            .focused($keyboardFocused)
                            
                    }
                }
                .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                .padding(.top, 28)
                .padding(.bottom, 55)
                
                // MARK: Confirm Payment Section
                Button {
                    keyboardFocused = false
                    isPresentingConfirmPayment = true
                    //self.isPresentingScanner = true
                } label: {
                    if paymentAmount == "" || paymentAmount == "0.00" {
                        Image("scanConfirmInactive")
                            .cornerRadius(8)
                    }
                    else {
                        Image("scanConfirmActive")
                            .cornerRadius(8)
                    }
                }
                .disabled({
                    if paymentAmount == "" || paymentAmount == "0.00" {
                        return true
                    }
                    else {
                        return false
                    }
                }())
                .sheet(isPresented: $isPresentingScanner) {
                    self.scannerSheet
                }
                Spacer()
            }
            
            ConfirmPaymentView(isPresenting: $isPresentingConfirmPayment, title: "details", subtitle: "Receive", amount: String(paymentAmount), account: "Balance", buttonTitle: "Receive", isLoading: $isPresentingScanner)
            
            WaitingPaymentView(isPresenting: $isLoading, isFinished: $isPresentingSuccesseReceive)
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Request payment")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
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
            keyboardFocused = false
        }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
        }))
        .sheet(isPresented: $isPresentingSuccesseReceive) {
            SuccessPaymentView(subtitle: "Successfully received", amount: String(paymentAmount), message: "To Balance", isPresenting: $isPresentingSuccesseReceive, finishedProcess: $finishedReceive)
        }
        .onChange(of: finishedReceive) { newValue in
            self.mode.wrappedValue.dismiss()
        }
    }
}

struct ScanPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ScanPaymentView()
            }
            
            NavigationView {
                ScanPaymentView(paymentAmount: "180.00", isPresentingConfirmPayment: true)
            }
        }
    }
}
