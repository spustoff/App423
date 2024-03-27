//
//  TabBar.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        
        HStack {
            
            ForEach(Tab.allCases, id: \.self) { index in
                
                Button(action: {
                    
                    selectedTab = index
                    
                }, label: {
                    
                    VStack(alignment: .center, spacing: 8, content: {
                        
                        Image(index.rawValue)
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == index ? Color("primary"): .gray)
                            .frame(height: 22)
                        
                        Text(index.rawValue)
                            .foregroundColor(selectedTab == index ? Color("primary") : .gray)
                            .font(.system(size: 12, weight: .regular))
                        
                    })
                    .frame(maxWidth: .infinity)
                })
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.top, 14)
        .padding(.bottom, 28)
        .background(Color.white)
    }
}

enum Tab: String, CaseIterable {
    
    case Holidays = "Holidays"
    
    case Calculations = "Calculations"
    
    case Settings = "Settings"
}


#Preview {
    
    ContentView()
}
