//
//  HolidaysAdd.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI

struct HolidaysAdd: View {
    
    @StateObject var viewModel: HolidaysViewModel
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
                        
                        Text("New Holiday")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .semibold))
                        
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                
                                viewModel.addHoliday()
                                viewModel.fetchHolidays()
                                
                                router.wrappedValue.dismiss()
                                
                                viewModel.name = ""
                                viewModel.cost = ""
                                viewModel.date = Date()
                                viewModel.purchases = ""
                                
                            }, label: {
                                
                                Text("Save")
                                    .foregroundColor(Color("primary"))
                                    .font(.system(size: 16, weight: .regular))
                            })
                            .opacity(viewModel.name.isEmpty || viewModel.cost.isEmpty || viewModel.purchases.isEmpty ? 0.5 : 1)
                            .disabled(viewModel.name.isEmpty || viewModel.cost.isEmpty || viewModel.purchases.isEmpty ? true : false)
                        }
                    }
                    .padding([.horizontal, .bottom])
                })
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        HStack {
                            
                            Text("Name")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.name.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.name)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                        
                        HStack {
                            
                            Text("Cost")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.cost.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.cost)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                                    .keyboardType(.decimalPad)
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                        
                        HStack {
                            
                            Text("Date and Time")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .medium))
                            
                            Spacer()
                            
                            DatePicker(selection: $viewModel.date, label: {})
                                .labelsHidden()
                        }
                        .padding()
                        
                        HStack {
                            
                            Text("Purchases")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.purchases.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.purchases)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
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
    HolidaysAdd(viewModel: HolidaysViewModel())
}
