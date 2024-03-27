//
//  CalculationsChart.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI

struct CalculationsChart: View {
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                
                ZStack {
                    
                    Text("Currency Pair")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .medium))
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.system(size: 10, weight: .bold))
                                .frame(width: 20, height: 20)
                                .background(Circle().fill(.gray.opacity(0.7)))
                        })
                        
                        Spacer()
                    }
                }
                .padding(.bottom, 40)
                .padding(.top)
                
                VStack(alignment: .leading, spacing: 10, content: {
                    
                    HStack(content: {
                        
                        Image("eurusd")
                        
                        Text("EUR/USD")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .medium))
                    })
                    
                    Text("Currency value")
                        .foregroundColor(.gray)
                        .font(.system(size: 12, weight: .semibold))
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                    Text("$\(String(format: "%.f", Double(.random(in: 40...60)))).\(String(format: "%.f", Double(.random(in: 10...80))))")
                        .foregroundColor(.black)
                        .font(.system(size: 25, weight: .semibold))
                    
                    Text("+ \(String(format: "%.f", Double(.random(in: 20...60)))).\(String(format: "%.f", Double(.random(in: 10...80))))")
                        .foregroundColor(.green)
                        .font(.system(size: 12, weight: .semibold))
                 
                    Spacer()
                }
                
                Image("graph")
                    .resizable()
                
                HStack {
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Text("Back")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.red))
                    })
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Text("Apply")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.green))
                    })
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    CalculationsChart()
}
