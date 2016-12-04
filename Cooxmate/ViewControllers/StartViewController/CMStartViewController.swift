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

	// MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

		self.recipeTableView?.estimatedRowHeight = UIConstant.CellIdentifier.CMStartIdentifer.cellHeight()

		FetchManager.fetchInitRequest(from: 0, to: 10) { [weak self] (recipes: [Recipe]?, error: NSError?) in
			if let recipes = recipes {
				self?.recipes = recipes
				self?.recipeTableView?.reloadData()
			}
		}
    }

	// MARK: - Navigation

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		if
			let overviewViewcontroller = segue.destination as? CMRecipeOverviewViewController,
			let recipe = sender as? Recipe,
			(segue.identifier == UIConstant.SegueIdentifier.PresentOverView.rawValue) {
				overviewViewcontroller.recipe = recipe
		}
	}
}

// MARK: - UITableview Delegate

extension CMStartViewController					: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (self.recipes.count)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: UIConstant.CellIdentifier.CMStartIdentifer.rawValue) as? CMStartTableViewCell else {
			return UITableViewCell()
		}
		cell.setContent(recipe: self.recipes[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: UIConstant.SegueIdentifier.PresentOverView.rawValue, sender: self.recipes[indexPath.row])
	}
}
