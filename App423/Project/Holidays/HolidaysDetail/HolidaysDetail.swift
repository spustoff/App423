//
//  HolidaysDetail.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI

struct HolidaysDetail: View {
    
    let index: HolidayModel
    
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
                        
                        Text("Holiday")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .semibold))
                    }
                })
                
                VStack(spacing: 25) {
                    
                    Image(systemName: "gift.fill")
                        .foregroundColor(Color("primary"))
                        .font(.system(size: 70, weight: .regular))
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Cost")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            Text("$\(index.cost)")
                                .foregroundColor(.black)
                                .font(.system(size: 23, weight: .semibold))
                            
                            Image("dollar")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        })
                        .padding([.leading, .top])
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary").opacity(0.3)))
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Date and Time")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            Text("\((index.date ?? Date()).convertDate(format: "MMM d HH:mm"))")
                                .foregroundColor(.black)
                                .font(.system(size: 23, weight: .semibold))
                            
                            Image("calendar")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        })
                        .padding([.leading, .top])
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary").opacity(0.3)))
                    }
                    
                    VStack(alignment: .leading, spacing: 10, content: {
                        
                        Text("Purchases")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium))
                        
                        Text(index.purchases ?? "")
                            .foregroundColor(.black.opacity(0.7))
                            .font(.system(size: 14, weight: .regular))
                        
                        Image("cart")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    })
                    .padding([.leading, .top])
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary").opacity(0.3)))
                }
                .padding()
            }
        }
    }
}

//#Preview {
//    HolidaysDetail()
//}
