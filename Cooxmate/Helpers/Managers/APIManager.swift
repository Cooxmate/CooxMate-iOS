//
//  APIManager.swift
//  Cooxmate
//
//  Created by Panajotis Maroungas on 05/11/16.
//  Copyright © 2016 Panajotis Maroungas. All rights reserved.
//

import Foundation
import Alamofire

struct APIManager {

	struct RequestData {

		// MARK: - Properties

		var url			: URL?

		// MARK: - Properties

		var method		: Alamofire.HTTPMethod
		var parameters	: [String : AnyObject]

		// MARK: - Initiliazers

		init(method: Alamofire.HTTPMethod, urlPath: String, parameters: [String : AnyObject]? = nil) {
			guard let baseURL = URL(string: APIConstant.baseURL) else {
				self.method 		= method
				self.parameters 	= parameters ?? [:]
				return
			}

			self.url		 	= baseURL.appendingPathExtension(urlPath)
			self.method 		= method
			self.parameters 	= parameters ?? [:]
		}
	}

	static func URLWithPath(path: String, withParameters parameters: [String: AnyObject]?) -> NSURL? {
		guard let baseUrl =	NSURL(string: APIConstant.baseURL) else {
			return nil
		}
		return baseUrl.appendingPathComponent(path) as NSURL?
	}

	static func sendRequest(requestData: RequestData, completion: ((_ dictionary: [String: AnyObject]?, _ error: Error?) -> Void)?) {
		guard let _url = requestData.url,
			(_url.absoluteString.isEmpty == false) else {
			completion?(nil, NSError(domain: "Empty url", code: 0, userInfo: nil))
			return
		}

		let request = Alamofire.request(_url, method: requestData.method, parameters: requestData.parameters, encoding: URLEncoding.default, headers: nil)

		request.responseJSON { (response: DataResponse) in
			guard let dictionary = response.result.value as? [String: AnyObject] else {
				completion?(nil, response.result.error)
				return
			}
			completion?(dictionary, nil)
		}
	}

}
