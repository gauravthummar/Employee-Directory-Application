//
//  Employee.swift
//  Employee Directory Application
//

import Foundation

struct Employees: Codable {
    let employees: [employee]?
}

struct employee: Codable {
    let full_name: String?
    let photo_url_small: String?
    let team: String?
}


