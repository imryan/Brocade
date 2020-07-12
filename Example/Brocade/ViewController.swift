//
//  ViewController.swift
//  Brocade
//
//  Created by Ryan Cohen on 03/31/2020.
//  Copyright (c) 2020 Ryan Cohen. All rights reserved.
//

import UIKit
import Brocade

class ViewController: UIViewController {
    
    // MARK: - IBOutlet -
    
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: - Attributes -
    
    private var brocade: Brocade!
    
    private var items: [Item] = [] {
        didSet {
            reloadTableView()
        }
    }
    
    private enum SearchType {
        case query
        case gtin
    }
    
    // MARK: - IBAction -
    
    @IBAction private func tappedSearchButtonQuery() {
        showAlertController(for: .query)
    }
    
    @IBAction private func tappedSearchButtonGtin() {
        showAlertController(for: .gtin)
    }
    
    // MARK: - UI Functions -
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        
        brocade = Brocade(delegate: self)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    private func showAlertController(for searchType: SearchType) {
        DispatchQueue.main.async {
            let queryType = (searchType == .query) ? "name" : "GTIN-14 code"
            let placeholder = (searchType == .query) ? "Milk" : "07790480000388"
            
            let alertController = UIAlertController(title: "Search Item", message: "Enter an item's \(queryType)", preferredStyle: .alert)
            
            alertController.addTextField { (textField) in
                textField.placeholder = placeholder
                textField.keyboardType = (searchType == .gtin) ? .numberPad : .default
                textField.autocapitalizationType = .words
            }
            
            let searchAction = UIAlertAction(title: "Search", style: .default) { [weak self] (_) in
                if let textField = alertController.textFields?.first, let query = textField.text, !query.isEmpty {
                    if searchType == .query {
                        self?.brocade.searchItem(query: query)
                    } else {
                        self?.brocade.getItem(code: query)
                    }
                }
            }
            
            alertController.addAction(searchAction)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func showAlertController(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        brocade.listItems()
    }
}

// MARK: - BrocadeProtocol -

extension ViewController: BrocadeProtocol {
    
    func receivedMultipleItems(_ items: [Item]?, _ error: Error?) {
        guard let items = items else {
            showAlertController(title: "Error", message: error?.localizedDescription ?? "No error info.")
            debugPrint("Error on receivedMultipleItems: \(error?.localizedDescription ?? "None")")
            return
        }
        
        self.items = items
    }
    
    func receivedSingleItem(_ item: Item?, _ error: Error?) {
        guard let item = item else {
            showAlertController(title: "Error", message: error?.localizedDescription ?? "No error info.")
            debugPrint("Error on receivedSingleItem: \(error?.localizedDescription ?? "None")")
            return
        }
        
        self.items = [item]
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Products"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.cellIdentifier, for: indexPath) as? ItemTableViewCell, indexPath.row < items.count else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        cell.setup(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        showAlertController(title: "Item", message: selectedItem.description)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
