//
//  recipesListViewController.swift
//  Reciplease
//
//  Created by ROUX Maxime on 01/10/2021.
//

import UIKit

class RecipesListViewController: UIViewController {

    // MARK: - Outlets
//    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var backNavigationItem: UINavigationItem!
    
    @IBAction func searchRecipesBiutton(_ sender: UIButton) {
    }
    

    
    
    
    
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let backItem = UIBarButtonItem(title: "Custom", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backItem

    }


}


// MARK: - UITableViewDataSource

extension RecipesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    return coreDataManager?.tasks.count ?? 0
        return 3
    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let taskCell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
//        taskCell.textLabel?.text = coreDataManager?.tasks[indexPath.row].name
//        return taskCell
//    }
}

// MARK: - UITableViewDelegate

extension RecipesListViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.text = "Add some tasks in the list"
//        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
//        label.textAlignment = .center
//        label.textColor = .darkGray
//        return label
//    }
//
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return coreDataManager?.tasks.isEmpty ?? true ? 200 : 0
        return 200
    }
}
