//
//  EmployeeCell.swift
//  Employee Directory Application
//

import Foundation
import Alamofire

protocol EmployeesInteractings: RequestHeadersAndParams {
    func fetchemployeesInfo(_ completion: @escaping (AnyObject?) -> Void)
}

class EmployeesInfoInteractor: URLRequestConvertible, EmployeesInteractings {

    func asURLRequest() throws -> URLRequest {
        var request = constructURLRequest()
        request.method = Alamofire.HTTPMethod.get
        request.headers = headers()
        request = try URLEncoding.default.encode(request, with: nil)
        
        return request
    }
    
    func fetchemployeesInfo(_ completion: @escaping (AnyObject?) -> Void) {
        AF.request(self).responseData { response in
            switch response.result {
            case .success:
                do {
                    if let data = response.data {
                        let employeesInfo =  try JSONDecoder().decode(Employees.self, from: data)
                        completion(employeesInfo as AnyObject)
                    } else {
                        completion(nil)
                    }
                } catch let error {
                    debugPrint("error during pasring is \(error)")
                    completion(error as AnyObject)
                }
            case .failure:
                completion(nil)
            }
        }
    }
}

extension EmployeesInfoInteractor {
    func constructURLRequest() -> URLRequest {
        if let url = URL(string: Constants.apiUrl) {
            return URLRequest(url: url)
        }
        return URLRequest(url: URL.errorUrl())
    }
}

extension URL {
    static func errorUrl() -> URL {
        return URL(string: "error")!
    }
}
