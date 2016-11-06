//
//  FetchManager.swift
//  Cooxmate
//
//  Created by Panajotis Maroungas on 06/11/16.
//  Copyright © 2016 Panajotis Maroungas. All rights reserved.
//

import Foundation
import RealmSwift

struct FetchManager {

	static var realm = try! Realm()

	static func fetchInitRequest(from: Int, to: Int, completion: ((recipes: [Recipe]?, error: NSError?) -> Void)?) {

		let initRequest = APIConstant.PathURL.Init.rawValue
		var parameters = [String: AnyObject]()

		parameters[APIConstant.InitReuqestParameter.From] = from
		parameters[APIConstant.InitReuqestParameter.To] = to

		let requestData = APIManager.RequestData(method: .GET, url: initRequest, parameters: parameters)

		APIManager.sendRequest(requestData) { (dictionary: [String: AnyObject]?, error: NSError?) in

			let results = dictionary?[APIConstant.ResponseKey.Result.rawValue] as? [[String: AnyObject]]

			do {
				try self.realm.write {
					for result in (results ?? []) {
						guard let recipeIdentifier = result[APIConstant.InitResponse.RecipeIdentifier] as? Int else {
							completion?(recipes: nil, error: NSError(domain: "Invalid indetifier", code: 0, userInfo: nil))
							return
						}

						let recipe = realm.objects(Recipe.self).filter("\(APIConstant.RecipeModel.RecipeIdentifier.rawValue) = \(recipeIdentifier)").first ?? Recipe(value: [APIConstant.RecipeModel.RecipeIdentifier.rawValue: recipeIdentifier])
						recipe.recipeDescription = result[APIConstant.InitResponse.RecipeDescription] as? String
						recipe.iconUrl = result[APIConstant.InitResponse.IconURL] as? String
						recipe.name = result[APIConstant.InitResponse.Name] as? String

						recipe.timePreparation = (result[APIConstant.InitResponse.TimePreperation]?.integerValue ?? 0)
						recipe.timestamp = result[APIConstant.InitResponse.Timestamp] as? String
						recipe.title = result[APIConstant.InitResponse.Title] as? String
						recipe.type = result[APIConstant.InitResponse.Type] as? String
						realm.add(recipe)

					}
				}
			} catch {
				completion?(recipes: nil, error: NSError(domain: "DB write error", code: 0, userInfo: nil))
			}


			let recipeObjects = self.realm.objects(Recipe)
			var recipes = [Recipe]()

			for recipe in recipeObjects {
				recipes.append(recipe)
			}
			completion?(recipes: recipes, error: nil)
		}
	}
}