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

		init(method: Alamofire.Method, url: NSURL, parameters: [String : AnyObject]? = nil) {
			self.method 		= method
			self.urlAsString 	= url.absoluteString
			self.parameters 	= parameters ?? [:]
		}

	}

	static func URLWithPath(path: String, withParameters parameters: [String: AnyObject]?) -> NSURL? {
		guard let baseUrl =	NSURL(string: APIConstant.baseURL) else {
			return nil
		}
		return baseUrl.URLByAppendingPathComponent(path)
	}

	private static func sendRequest(requestData: RequestData, completion: ((dictionary: [String: AnyObject]?, error: NSError?) -> Void)?) {

		let request = Alamofire.request(requestData.method, requestData.urlAsString, parameters: requestData.parameters, encoding: .JSON, headers: nil)
		request.responseJSON { (response: Response) in
			guard let dictionary = response.result.value as? [String: AnyObject] else {
				completion?(dictionary: nil, error: response.result.error)
				return
			}
			completion?(dictionary: dictionary, error: nil)
		}
	}

}

extension APIManager {

}
