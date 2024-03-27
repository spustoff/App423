//
//  CalculationsView.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI

struct CalculationsView: View {
    
    @StateObject var viewModel = CalculationsViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Image("eurusd")
                    
                    Text("EUR/USD")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .regular))
                    
                    Spacer()
                    
                    Image("dollar2")
                }
                .padding([.leading])
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary").opacity(0.2)))
                .padding([.horizontal, .top])
                
                Button(action: {
                    
                    viewModel.isChart = true
                    
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
                    
                    Text("Holiday cost calculations")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .semibold))
                    
                    Spacer()
                    
                }
                .padding([.horizontal, .bottom])
                
                HStack {
                    
                    ForEach(viewModel.tabs, id: \.self) { index in
                    
                        Button(action: {
                            
                            viewModel.current_tab = index
                            viewModel.fetchCalculations()
                            
                        }, label: {
                            
                            Text(index)
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .frame(height: 30)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(viewModel.current_tab == index ? 1 : 0)))
                        })
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, 3)
                .frame(height: 35)
                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                .padding([.horizontal])
                
                switch viewModel.current_tab {
                    
                case "Calculator":
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            HStack {
                                
                                Text("Name Holiday")
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
                            .background(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.3)))
                            
                            HStack {
                                
                                Text("Gifts")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .medium))
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Enter")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.gifts.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.gifts)
                                        .foregroundColor(.black)
                                        .font(.system(size: 14, weight: .regular))
                                        .keyboardType(.decimalPad)
                                })
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.3)))
                            
                            HStack {
                                
                                Text("Meal")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .medium))
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Enter")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.meal.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.meal)
                                        .foregroundColor(.black)
                                        .font(.system(size: 14, weight: .regular))
                                        .keyboardType(.decimalPad)
                                })
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.3)))
                            
                            HStack {
                                
                                Text("Drinks")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .medium))
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Enter")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.drinks.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.drinks)
                                        .foregroundColor(.black)
                                        .font(.system(size: 14, weight: .regular))
                                        .keyboardType(.decimalPad)
                                })
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.3)))
                            
                            HStack {
                                
                                Text("Rent a Room")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .medium))
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Enter")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.rent_a_room.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.rent_a_room)
                                        .foregroundColor(.black)
                                        .font(.system(size: 14, weight: .regular))
                                        .keyboardType(.decimalPad)
                                })
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.3)))
                            
                            HStack {
                                
                                Text("Decorating")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .medium))
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Enter")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.decorating.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.decorating)
                                        .foregroundColor(.black)
                                        .font(.system(size: 14, weight: .regular))
                                        .keyboardType(.decimalPad)
                                })
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.3)))
                            
                            Button(action: {
                                
                                viewModel.isResult = true
                                
                            }, label: {
                                
                                Text("Calculate")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .medium))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                                    .padding([.bottom])
                            })
                            .opacity(viewModel.name.isEmpty || viewModel.gifts.isEmpty || viewModel.meal.isEmpty || viewModel.drinks.isEmpty || viewModel.rent_a_room.isEmpty || viewModel.decorating.isEmpty ? 0.5 : 1)
                            .disabled(viewModel.name.isEmpty || viewModel.gifts.isEmpty || viewModel.meal.isEmpty || viewModel.drinks.isEmpty || viewModel.rent_a_room.isEmpty || viewModel.decorating.isEmpty ? true : false)
                        }
                        .padding()
                    }
                case "Saved":
                    if viewModel.saved_calculations.isEmpty {
                        
                        Text("Your saved calculations\nwill be stored here")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .multilineTextAlignment(.center)
                            .frame(maxHeight: .infinity, alignment: .center)
                        
                    } else {
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.saved_calculations, id: \.self) { index in
                                
                                    HStack(alignment: .bottom, spacing: 20) {
                                        
                                        Image("gift2")
                                        
                                        VStack(alignment: .leading, spacing: 10, content: {
                                            
                                            Text(index.name ?? "")
                                                .foregroundColor(.black)
                                                .font(.system(size: 16, weight: .regular))
                                                .multilineTextAlignment(.leading)
                                            
                                            Text("\(index.result)")
                                                .foregroundColor(.black)
                                                .font(.system(size: 19, weight: .semibold))
                                                .multilineTextAlignment(.leading)
                                        })
                                        .padding(.vertical)
                                        
                                        Spacer()
                                    }
                                    .padding([.top, .trailing])
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary").opacity(0.2)))
                                }
                            }
                            .padding()
                        }
                    }
                    
                default:
                    Text("")
                }
            }
        }
        .sheet(isPresented: $viewModel.isResult, content: {
            
            CalculationsResult(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isChart, content: {
            
            CalculationsChart()
        })
    }
}

#Preview {
    CalculationsView()
}
