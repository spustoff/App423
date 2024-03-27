//
//  HolidaysViewModel.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI
import CoreData

final class HolidaysViewModel: ObservableObject {

    @Published var holidays: [HolidayModel] = []
    
    @Published var isEdit: Bool = false
    @Published var isAdd: Bool = false
    @Published var isDetail: Bool = false
    
    @Published var selectedHoliday: HolidayModel? = nil
    
    @Published var name: String = ""
    @Published var cost: String = ""
    @Published var date: Date = Date()
    @Published var purchases: String = ""
    
    @AppStorage("total_amount") var total_amount: String = ""
    @AppStorage("quantity_holidays") var quantity_holidays: String = ""
    
    func addHoliday() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "HolidayModel", into: context) as! HolidayModel
        
        loan.name = name
        loan.cost = Int16(cost) ?? 0
        loan.date = date
        loan.purchases = purchases
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchHolidays() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<HolidayModel>(entityName: "HolidayModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.holidays = result
            
        } catch _ as NSError {
            
            self.holidays = []
        }
    }
}
