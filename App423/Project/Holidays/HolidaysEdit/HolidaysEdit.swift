//
//  HolidaysEdit.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI

struct HolidaysEdit: View {
    
    @StateObject var viewModel = HolidaysViewModel()
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg2")
                .ignoresSafeArea()
            
            VStack {
                
                VStack(alignment: .center, spacing: 20, content: {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 40, height: 5)
                        .foregroundColor(.gray.opacity(0.4))
                    
                    ZStack {
                        
                        Text("Editing Cards")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .semibold))
                        
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                
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
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        HStack {
                            
                            Text("Total Amount")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.total_amount.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.total_amount)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                                    .keyboardType(.decimalPad)
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                        
                        HStack {
                            
                            Text("Quantity Holidays")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.quantity_holidays.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.quantity_holidays)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                                    .keyboardType(.decimalPad)
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    HolidaysEdit()
}
