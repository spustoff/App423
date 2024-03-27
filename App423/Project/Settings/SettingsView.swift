//
//  SettingsView.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Settings")
                    .foregroundColor(.black)
                    .font(.system(size: 23, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Button(action: {
                    
                    SKStoreReviewController.requestReview()
                    
                }, label: {
                    
                    VStack(alignment: .center, spacing: 5, content: {
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .medium))
                        
                        Text("Rate App")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .medium))
                    })
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary").opacity(0.2)))
                    .padding(.horizontal)
                })
                
                Button(action: {
                    
                    guard let url = URL(string: DataManager().usagePolicy) else { return }
                    
                    UIApplication.shared.open(url)
                    
                }, label: {
                    
                    VStack(alignment: .center, spacing: 5, content: {
                        
                        Image(systemName: "doc.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .medium))
                        
                        Text("Usage Policy")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .medium))
                    })
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary").opacity(0.2)))
                    .padding(.horizontal)
                })
                
                Button(action: {
                    
                    CoreDataStack.shared.deleteAllData()
                    
                }, label: {
                    
                    VStack(alignment: .center, spacing: 5, content: {
                        
                        Image(systemName: "trash.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .medium))
                        
                        Text("Reset Progress")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .medium))
                    })
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary").opacity(0.2)))
                    .padding(.horizontal)
                })
                
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView()
}
