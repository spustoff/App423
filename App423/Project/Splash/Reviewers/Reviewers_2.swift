//
//  Reviewers_2.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI

struct Reviewers_2: View {
    var body: some View {
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            Image("reviewers_2")
                .resizable()
            
            VStack {
            
                VStack(alignment: .center, spacing: 5, content: {
                    
                    Text("Calculate your expenses")
                        .foregroundColor(.black)
                        .font(.system(size: 23, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Text("All expenses are accounted for")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                })
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
                
                Spacer()
                
                NavigationLink(destination: {
                    
                    Reviewers_3()
                        .navigationBarBackButtonHidden()
                    
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
    }
}

#Preview {
    Reviewers_2()
}
