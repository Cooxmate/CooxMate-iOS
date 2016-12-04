//
//  UIConstants.swift
//  Cooxmate
//
//  Created by Panajotis Maroungas on 06/11/16.
//  Copyright © 2016 Panajotis Maroungas. All rights reserved.
//

import Foundation
import UIKit

struct UIConstant {
	enum CellIdentifier 		: String {
		case CMStartIdentifer 	= "CMStartIdentifer"

		func cellHeight() -> CGFloat {
			switch self {
			case .CMStartIdentifer	: return 400
			}
		}
	}

	enum SegueIdentifier		: String {
		case PresentOverView 	= "presentOverViewIdentifier"
	}
}
