//
//  Model.swift
//  Cooxmate
//
//  Created by Panajotis Maroungas on 06/11/16.
//  Copyright © 2016 Panajotis Maroungas. All rights reserved.
//

import Foundation
import RealmSwift

class Recipe: Object {

	dynamic var recipeDescription 	: String?
	dynamic var iconUrl 			: String?
	dynamic var name 				: String?
	dynamic var recipeIdentifier  	= 0
	dynamic var timestamp 			: String?
	dynamic var title 				: String?
	dynamic var type 				: String?
	dynamic var timePreparation 	= 0

	override static func primaryKey() -> String? {
		return "recipeIdentifier"
	}
}
