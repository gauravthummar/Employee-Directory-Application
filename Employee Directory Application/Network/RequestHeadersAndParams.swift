//
//  EmployeeCell.swift
//  Employee Directory Application
//

import Alamofire
import Foundation

protocol RequestHeadersAndParams {
	func headers() -> HTTPHeaders
	func params() -> [String: Any]
}

extension RequestHeadersAndParams {
	func headers() -> HTTPHeaders {
        return [HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
				HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue,
		]
	}
	
	func formHeaders() -> HTTPHeaders {
		return [HTTPHeaderField.contentType.rawValue: ContentType.form.rawValue,
				HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue,
		]
	}
	
	func params() -> [String: Any] {
        let params: [String: Any] = [:]
		return params
	}
}
