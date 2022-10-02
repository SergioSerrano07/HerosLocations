//
//  TableViewController.swift
//  AppleMaps
//
//  Created by sergio serrano on 29/9/22.
//

import UIKit
import KeychainSwift



final class TableViewController: UITableViewController {
    
    let viewModel = TableViewModel()
    
    private var hero: HeroService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes"
        
        navigationController?.navigationBar.isHidden = false
        
        tableView?.register(
            UINib(nibName: "TableViewCell", bundle: nil),
            forCellReuseIdentifier: "reuseIdentifier"
        )
        
        viewModel.onError = { errorMessage in
            print(errorMessage)
        }
        
        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.content.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? TableViewCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "no content"
            return cell
        }
        cell.set(model: viewModel.content[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let locations = viewModel.locationsContent else {
            return
        }
        
        let nextVC = MapViewController()
        nextVC.hero = hero
        nextVC.set(model: locations)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
