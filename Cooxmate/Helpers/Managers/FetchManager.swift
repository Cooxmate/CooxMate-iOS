//
//  FetchManager.swift
//  Cooxmate
//
//  Created by Panajotis Maroungas on 06/11/16.
//  Copyright © 2016 Panajotis Maroungas. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire

struct FetchManager {

	static var realm = try! Realm()

	static func fetchInitRequest(from: Int, to: Int, completion: ((_ recipes: [Recipe]?, _ error: NSError?) -> Void)?) {

		let initRequest = APIConstant.PathURL.Init.rawValue
		var parameters = [String: AnyObject]()

		parameters[APIConstant.InitReuqestParameter.From] = from as AnyObject?
		parameters[APIConstant.InitReuqestParameter.To] = to as AnyObject?

		let requestData = APIManager.RequestData(method: .get, urlPath: initRequest, parameters: parameters)

		APIManager.sendRequest(requestData: requestData) { (dictionary: [String: AnyObject]?, error: Swift.Error?) in

			let results = dictionary?[APIConstant.ResponseKey.Result.rawValue] as? [[String: AnyObject]]

			do {
				try self.realm.write {
					for result in (results ?? []) {
						guard let recipeIdentifier = result[APIConstant.InitResponse.RecipeIdentifier] as? Int else {
							completion?(nil, NSError(domain: "Invalid indetifier", code: 0, userInfo: nil))
							return
						}

						let recipe = realm.objects(Recipe.self).filter("\(APIConstant.RecipeModel.RecipeIdentifier.rawValue) = \(recipeIdentifier)").first ?? Recipe(value: [APIConstant.RecipeModel.RecipeIdentifier.rawValue: recipeIdentifier])
						recipe.recipeDescription = result[APIConstant.InitResponse.RecipeDescription] as? String
						recipe.iconUrl = result[APIConstant.InitResponse.IconURL] as? String
						recipe.name = result[APIConstant.InitResponse.Name] as? String

						recipe.timePreparation = (result[APIConstant.InitResponse.TimePreperation]?.integerValue ?? 0)
						recipe.timestamp = result[APIConstant.InitResponse.Timestamp] as? String
						recipe.title = result[APIConstant.InitResponse.Title] as? String
						recipe.type = result[APIConstant.InitResponse.RecipeType] as? String
						realm.add(recipe)

					}
				}
			} catch {
				completion?(nil, NSError(domain: "DB write error", code: 0, userInfo: nil))
			}


			let recipeObjects = self.realm.objects(Recipe.self)
			var recipes = [Recipe]()

			for recipe in recipeObjects {
				recipes.append(recipe)
			}
			completion?(recipes, nil)
		}
	}
}
