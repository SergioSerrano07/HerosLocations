//
//  TableViewController + Search.swift
//  AppleMaps
//
//  Created by sergio serrano on 2/10/22.
//

import UIKit


extension TableViewController {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered.removeAll(keepingCapacity: false)
        let predicate = searchBar.text!
        filtered = viewModel.content.filter({ $0.name.range(of: predicate) != nil })
        filtered.sort {$0.name < $1.name}
        isSearching = (filtered.count == 0) ? false: true
        tableView.reloadData()
    }
}
