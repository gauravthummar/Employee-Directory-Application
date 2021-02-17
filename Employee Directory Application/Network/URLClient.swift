//
//  EmployeeCell.swift
//  Employee Directory Application
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
	case referer = "Referer"
	case userAgent = "User-Agent"
}

enum ContentType: String {
    case json = "application/json"
	case form = "application/x-www-form-urlencoded"
}

protocol URLRouterProtocol: URLRequestConvertible {
	var baseURL: URL { get }
	var env: String { get }
	var path: String { get }
	var method: Alamofire.HTTPMethod { get }
	func parameters() -> Parameters?
}

extension URLRouterProtocol {
	func asURLRequest() throws -> URLRequest {
		return try URLClient.urlRequestCommon(router: self)
	}
}

class URLClient: NSObject {
	@discardableResult
	static func performRequest<T: Decodable>(route: URLRouterProtocol, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (AFResult<T>) -> Void) -> DataRequest {
		return AF.request(route)
			.responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in
				completion(response.result)
		}
    }
	
    // MARK: - URLRequestConvertible handler
	static func urlRequestCommon(router: URLRouterProtocol) throws -> URLRequest {
		let url = router.baseURL
		var urlRequest = URLRequest(url: url.appendingPathComponent(router.path))
        // HTTP Method
		urlRequest.httpMethod = router.method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        // Parameters
		if let parameters = router.parameters() {
            do {
				let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                urlRequest.httpBody = jsonData
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
