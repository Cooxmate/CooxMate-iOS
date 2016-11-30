//
//  CMStartViewController.swift
//  Cooxmate
//
//  Created by Panajotis Maroungas on 06/11/16.
//  Copyright © 2016 Panajotis Maroungas. All rights reserved.
//

import UIKit

class CMStartViewController						: UIViewController {

	// MARK: - Outlets

	@IBOutlet private weak var recipeTableView	: UITableView?

	// MARK: - Properties

	internal var recipes = [Recipe]()

    override func viewDidLoad() {
        super.viewDidLoad()

		FetchManager.fetchInitRequest(from: 0, to: 10) { [weak self] (recipes: [Recipe]?, error: NSError?) in
			if let recipes = recipes {
				self?.recipes = recipes
				self?.recipeTableView?.reloadData()
			}
		}

    }
}

extension CMStartViewController					: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (self.recipes.count)
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UIConstant.CellIdentifier.CMStartIdentifer.cellHeight()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: UIConstant.CellIdentifier.CMStartIdentifer.rawValue) as? CMStartTableViewCell else {
			return UITableViewCell()
		}
		cell.setContent(recipe: self.recipes[indexPath.row])
		return cell
	}
}
