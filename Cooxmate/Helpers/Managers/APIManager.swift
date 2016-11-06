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

		private var method		: Alamofire.Method
		private var urlAsString	: String
		private var parameters	: [String : AnyObject]

		// MARK: - Initiliazers

		init(method: Alamofire.Method, url: String, parameters: [String : AnyObject]? = nil) {
			guard let baseURL = NSURL(string: APIConstant.baseURL) else {
				self.method 		= method
				self.urlAsString 	= ""
				self.parameters 	= parameters ?? [:]
				return
			}

			let completeURL 	= baseURL.URLByAppendingPathComponent(url)
			self.method 		= method
			self.urlAsString 	= completeURL.absoluteString
			self.parameters 	= parameters ?? [:]
		}

	}

	static func URLWithPath(path: String, withParameters parameters: [String: AnyObject]?) -> NSURL? {
		guard let baseUrl =	NSURL(string: APIConstant.baseURL) else {
			return nil
		}
		return baseUrl.URLByAppendingPathComponent(path)
	}

	static func sendRequest(requestData: RequestData, completion: ((dictionary: [String: AnyObject]?, error: NSError?) -> Void)?) {
		guard (requestData.urlAsString.isEmpty == false) else {
			completion?(dictionary: nil, error: NSError(domain: "Empty url", code: 0, userInfo: nil))
			return
		}

		let request = Alamofire.request(requestData.method, requestData.urlAsString, parameters: requestData.parameters, headers: nil)

		request.responseJSON { (response: Response) in
			guard let dictionary = response.result.value as? [String: AnyObject] else {
				completion?(dictionary: nil, error: response.result.error)
				return
			}
			completion?(dictionary: dictionary, error: nil)
		}
	}

}
