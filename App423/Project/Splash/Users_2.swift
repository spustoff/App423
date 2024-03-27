//
//  Users_2.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI
import StoreKit

struct Users_2: View {
    
    let telegram: URL
    let isTelegram: Bool
    
    var body: some View {
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            Image("users_2")
                .resizable()
            
            VStack {
            
                VStack(alignment: .center, spacing: 5, content: {
                    
                    Text("Rate our app in the\nAppStore")
                        .foregroundColor(.black)
                        .font(.system(size: 23, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Text("Help make the app even better")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                })
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
                
                Spacer()
                
                NavigationLink(destination: {
                    
                    if isTelegram == true {
                        
                        Users_3(telegram: telegram)
                            .navigationBarBackButtonHidden()
                        
                    } else if isTelegram == false {
                        
                        Users_4()
                            .navigationBarBackButtonHidden()
                    }
                    
                }, label: {
                    
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                        .padding()
                })
            }
        }
        .onAppear {
            
            SKStoreReviewController.requestReview()
        }
    }
}

#Preview {
    Users_2(telegram: URL(string: "f")!, isTelegram: false)
}
