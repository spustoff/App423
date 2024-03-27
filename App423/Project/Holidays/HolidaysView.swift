//
//  HolidaysView.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI

struct HolidaysView: View {
    
    @StateObject var viewModel = HolidaysViewModel()
    
    var body: some View {
    
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    VStack(alignment: .leading, spacing: 10, content: {
                        
                        Text("Total Amount")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium))
                        
                        Text("$\(viewModel.total_amount.isEmpty ? "0" : viewModel.total_amount)")
                            .foregroundColor(.black)
                            .font(.system(size: 23, weight: .semibold))
                        
                        Image("dollar")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    })
                    .padding([.leading, .top])
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary").opacity(0.2)))
                    
                    VStack(alignment: .leading, spacing: 10, content: {
                        
                        Text("Quantity Holidays")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium))
                        
                        Text("\(viewModel.quantity_holidays.isEmpty ? "0" : viewModel.quantity_holidays)")
                            .foregroundColor(.black)
                            .font(.system(size: 23, weight: .semibold))
                        
                        Image("gift")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    })
                    .padding([.leading, .top])
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary").opacity(0.2)))
                }
                .padding([.top, .horizontal])
                
                Button(action: {
                    
                    viewModel.isEdit = true
                    
                }, label: {
                    
                    Text("Edit")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding([.horizontal, .bottom])
                })
                
                HStack {
                    
                    Text("Holidays")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        viewModel.isAdd = true
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 18, weight: .semibold))
                    })
                }
                .padding([.horizontal])
                
                if viewModel.holidays.isEmpty {
                    
                    Text("There are no scheduled\nholidays for this day")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.holidays, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.selectedHoliday = index
                                    viewModel.isDetail = true
                                    
                                }, label: {
                                    
                                    HStack(alignment: .bottom, spacing: 20) {
                                        
                                        Image("gift2")
                                        
                                        VStack(alignment: .leading, spacing: 10, content: {
                                            
                                            Text(index.name ?? "")
                                                .foregroundColor(.black)
                                                .font(.system(size: 16, weight: .semibold))
                                                .multilineTextAlignment(.leading)
                                            
                                            Text("\((index.date ?? Date()).convertDate(format: "MMM d"))\n\((index.date ?? Date()).convertDate(format: "HH:mm"))")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                                .multilineTextAlignment(.leading)
                                        })
                                        .padding(.vertical)
                                        
                                        Spacer()
                                        
                                        Text("$\(index.cost)")
                                            .foregroundColor(.black)
                                            .font(.system(size: 19, weight: .semibold))
                                            .padding(.bottom, 40)
                                    }
                                    .padding([.top, .trailing])
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary").opacity(0.2)))
                                })
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchHolidays()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            HolidaysAdd(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isEdit, content: {
            
            HolidaysEdit()
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            if let index = viewModel.selectedHoliday {
                
                HolidaysDetail(index: index)
            }
        })
    }
}

#Preview {
    HolidaysView()
}
