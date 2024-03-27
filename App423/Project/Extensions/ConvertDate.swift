//
//  ConvertDate.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI

extension Date {
    
    func convertDate(format: String) -> String {
        
        let date = self
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}
