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

	private var recipes = [Recipe]()

    override func viewDidLoad() {
        super.viewDidLoad()

		FetchManager.fetchInitRequest(0, to: 10) { [weak self] (recipes: [Recipe]?, error: NSError?) in
			if let recipes = recipes {
				self?.recipes = recipes
				self?.recipeTableView?.reloadData()
			}
		}

    }
}

extension CMStartViewController					: UITableViewDelegate, UITableViewDataSource {

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (self.recipes.count ?? 0)
	}

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UIConstant.CellIdentifier.CMStartIdentifer.cellHeight()
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCellWithIdentifier(UIConstant.CellIdentifier.CMStartIdentifer.rawValue) as? CMStartTableViewCell else {
			return UITableViewCell()
		}
		cell.setContent(self.recipes[indexPath.row])
		return cell
	}
}
