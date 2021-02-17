//
//  EmployeesList.swift
//  Employee Directory Application
//

import UIKit
struct Constants {
    static let apiUrl = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    static let serverErrorMessage = "Something went wrong, please try agian."
}
class EmployeesList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let employeesViewModel = EmployeesViewModel()
    var employeesArray: [employee] = []
    let cellReuseIdentifier = "cell"
    @IBOutlet weak var employeesTable: UITableView?
    @IBOutlet weak var errorLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        employeesViewModel.loadEmployeesData(){ (employees, succeeded) in
            activityIndicator.removeFromSuperview()
            if let employeesArray = employees as? Employees {
                self.employeesArray = employeesArray.employees ?? []
                if self.employeesArray.count > 0 {
                    self.employeesTable?.reloadData()
                    self.employeesTable?.tableFooterView = UIView()
                    self.employeesTable?.isHidden = false
                } else {
                    self.employeesTable?.isHidden = true
                    self.errorLabel?.isHidden = false
                }
            } else {
                self.employeesTable?.isHidden = true
                self.errorLabel?.isHidden = false
                self.errorLabel?.text = Constants.serverErrorMessage
            }
        }
    }
    
    // MARK: - TableView Method
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0;
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.employeesArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! EmployeeCell

        // set the text from the data model
        let employee = self.employeesArray[indexPath.row]
        cell.fullName?.text = employee.full_name
        cell.team?.text = employee.team
        cell.employeePhoto?.downloadImageFrom(employee.photo_url_small ?? "")
        return cell
    }
}
