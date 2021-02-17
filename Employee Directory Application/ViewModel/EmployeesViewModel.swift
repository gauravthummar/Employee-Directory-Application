//
//  EmployeeCell.swift
//  Employee Directory Application
//

import Foundation

class EmployeesViewModel: ObservableObject {
    let employeesInfoInteractor = EmployeesInfoInteractor()
    init(employeesInfoInteractor: EmployeesInteractings = EmployeesInfoInteractor()) {

    }
    func loadEmployeesData( completion: @escaping (_ employees: AnyObject,_ succeeded: Bool) -> Void){
        employeesInfoInteractor.fetchemployeesInfo { result in
        guard let item = result else {
               return
            }
            DispatchQueue.main.async {
                completion(item, true)
            }
        }
    }
}
