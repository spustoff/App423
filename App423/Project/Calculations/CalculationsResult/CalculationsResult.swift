//
//  CalculationsResult.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI

struct CalculationsResult: View {
    
    @Environment(\.presentationMode) var router
    @StateObject var viewModel: CalculationsViewModel
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            let result = Int16.random(in: 1000...24000)
            
            VStack {
                
                VStack(alignment: .center, spacing: 20, content: {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 40, height: 5)
                        .foregroundColor(.gray.opacity(0.4))
                    
                    ZStack {
                        
                        Text("Result")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .semibold))
                        
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                
                                viewModel.addCalculation(result: result)
                                viewModel.fetchCalculations()
                                
                                router.wrappedValue.dismiss()
                                
                            }, label: {
                                
                                Text("Save")
                                    .foregroundColor(Color("primary"))
                                    .font(.system(size: 16, weight: .regular))
                            })
                        }
                    }
                    .padding([.horizontal, .bottom])
                })
                
                VStack(spacing: 25) {
                    
                    Image(systemName: "dollarsign")
                        .foregroundColor(Color("primary"))
                        .font(.system(size: 70, weight: .regular))
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Cost of Holiday")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            Text("$\(result)")
                                .foregroundColor(.black)
                                .font(.system(size: 23, weight: .semibold))
                            
                            Image("dollar")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        })
                        .padding([.leading, .top])
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary").opacity(0.3)))
                    }
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Text("Close")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                    })
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    CalculationsResult(viewModel: CalculationsViewModel())
}
