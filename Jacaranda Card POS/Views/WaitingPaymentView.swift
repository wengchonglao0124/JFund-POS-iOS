//
//  WaitingPaymentView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 30/10/2022.
//

import SwiftUI

struct WaitingPaymentView: View {
    
    @Binding var isPresenting: Bool
    @Binding var isFinished: Bool
    
    var body: some View {
        VStack {
            if isPresenting {
                VStack {
                    Spacer()
                    VStack(spacing: 0) {
                        
                        ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 97/255, green: 56/255, blue: 129/255)))
                        .scaleEffect(2)
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                        
                        Text("Waiting for customer to confirm")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                            .padding(.bottom, 24)

                        HStack {
                            Spacer()
                            Button {
                                isPresenting = false
                            } label: {
                                Text("Cancel")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(red: 122/255, green: 126/255, blue: 128/255))
                                    .padding(.bottom, 45)
                            }
                            Spacer()
                        }
                    }
                    .padding(.bottom, 37)
                    .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                    .cornerRadius(16)
                }
                .background(Color(red: 0, green: 0, blue: 0, opacity: 0.2))
                .onAppear(
                    perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            if isPresenting {
                                isPresenting = false
                                isFinished = true
                            }
                        }
                    }
                )
            }
        }
        .edgesIgnoringSafeArea(.all)
        .animation(.easeInOut, value: isPresenting)
    }
}

struct WaitingPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingPaymentView(isPresenting: .constant(true), isFinished: .constant(false))
    }
}
