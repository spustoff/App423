//
//  CalculationsViewModel.swift
//  App423
//
//  Created by Вячеслав on 3/25/24.
//

import SwiftUI
import CoreData

final class CalculationsViewModel: ObservableObject {
    
    @Published var saved_calculations: [CalculationsModel] = []
    
    @Published var isResult: Bool = false
    @Published var isChart: Bool = false
    
    @Published var tabs: [String] = ["Calculator", "Saved"]
    @Published var current_tab: String = "Calculator"
    
    @Published var name: String = ""
    @Published var gifts: String = ""
    @Published var meal: String = ""
    @Published var drinks: String = ""
    @Published var rent_a_room: String = ""
    @Published var decorating: String = ""
    
    func addCalculation(result: Int16) {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "CalculationsModel", into: context) as! CalculationsModel
        
        loan.name = name
        loan.result = result
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchCalculations() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CalculationsModel>(entityName: "CalculationsModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.saved_calculations = result
            
        } catch _ as NSError {
            
            self.saved_calculations = []
        }
    }
}
