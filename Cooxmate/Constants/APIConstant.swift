//
//  APIConstant.swift
//  Cooxmate
//
//  Created by Panajotis Maroungas on 06/11/16.
//  Copyright © 2016 Panajotis Maroungas. All rights reserved.
//

import Foundation

struct APIConstant {

	static let baseURL 	= "http://127.0.0.1:8888"

	enum ResponseKey	: String {
		case Result		= "results"
	}

	enum PathURL		: String {
		case Init		= "init"
	}

	struct InitReuqestParameter {
		static let From = "from"
		static let To 	= "to"
	}

	struct InitResponse {
		static let RecipeDescription	= "description"
		static let IconURL				= "icon_url"
		static let Name					= "name"
		static let Publish				= "publish"
		static let RecipeIdentifier		= "recipe_id"
		static let TimePreperation		= "time_preparation"
		static let Timestamp			= "timestamp"
		static let Title				= "title"
		static let Type					= "type"
	}

	enum RecipeModel			: String {
		case RecipeIdentifier 	= "recipeIdentifier"
	}
}
