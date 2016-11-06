//
//  CMStartTableViewCell.swift
//  Cooxmate
//
//  Created by Panajotis Maroungas on 06/11/16.
//  Copyright © 2016 Panajotis Maroungas. All rights reserved.
//

import Foundation
import UIKit

class CMStartTableViewCell: UITableViewCell {

	// MARK: - Outlets

	@IBOutlet private weak var recipeImageView					: UIImageView?
	@IBOutlet private weak var timeLabel						: UILabel?
	@IBOutlet private weak var typeLabel						: UILabel?
	@IBOutlet private weak var titleLabel						: UILabel?
	@IBOutlet private weak var descriptionLabel					: UILabel?
	@IBOutlet private weak var timePreparationPlaceHolderView	: UIView?


	func setContent(recipe: Recipe?) {

		if let timePreparationPlaceHolderViewFrame = self.timePreparationPlaceHolderView?.frame {
			self.timePreparationPlaceHolderView?.layer.cornerRadius = (timePreparationPlaceHolderViewFrame.size.width * 0.5)
		}

		if let timePreparation = recipe?.timePreparation {
			self.timeLabel?.text 		= "\(timePreparation)"
		}
		self.typeLabel?.text 		= recipe?.type
		self.titleLabel?.text 		= recipe?.title
		self.descriptionLabel?.text = recipe?.recipeDescription
	}
}
