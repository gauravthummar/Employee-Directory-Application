//
//  EmployeesViewModel.swift
//  Employee Directory ApplicationTests
//
import Foundation
import XCTest
@testable import Employee_Directory_Application

class EmployeesVMInteractorMock: EmployeesInfoInteractor {
    
    private var url: URL
    
    init(_ url: URL) {
        self.url = url
    }
    
    override func fetchemployeesInfo(_ completion: @escaping (AnyObject?) -> Void) {
        do {
           if let jsonData = try String(contentsOf: url).data(using: .utf8) {
               let employeesInfo =  try JSONDecoder().decode(Employees.self, from: jsonData)
               completion(employeesInfo as AnyObject?)
           }
       } catch {
           completion(nil)
       }
    }
}

class EmployeesViewModelTest: XCTestCase {
    
    override func setUp() {
        
    }
    
    func test_fetchemployeesInfo() {
        let employeesInfo = URL(fileURLWithPath: Bundle.main.path(forResource: "employees", ofType: "json")!)
        let employeesViewModel = EmployeesViewModel(employeesInfoInteractor: EmployeesVMInteractorMock(employeesInfo))
        employeesViewModel.loadEmployeesData(){ (employees, true ) in
            XCTAssertNotNil(employees as? Employees != nil, "EmployeesViewModel shouldn't be nil")
        }
    }

}
