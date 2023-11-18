//
//  ListController.swift
//  ToDoList
//
//  Created by Эля Корельская on 26.10.2023.
//

import UIKit

class ListController: UITableViewController {
    // MARK: - Properties
    var model = Model()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Method
    @IBAction func pushAddAction(_ sender: Any) {
        /// убираем утечки памяти из-за замыкания
        TextPicker().showText(in: self) {
            [weak self] text in
            self?.model.addItem(title: text)
            self?.tableView.reloadData()
        }
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configuration = UIListContentConfiguration.cell()
        configuration.text = model.items[indexPath.row].title
        configuration.secondaryText = model.items[indexPath.row].date.formatted(date: .complete, time: .shortened)
        cell.contentConfiguration = configuration
        cell.accessoryType = model.items[indexPath.row].isCompleted ? .checkmark : .none

        return cell
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "Rename") {
           _,_,completion in
            TextPicker().showText(in: self) {
                [weak self] text in
                self?.model.removeItem(atIndex: indexPath.row, newTitle: text)
                self?.tableView.reloadRows(at: [indexPath], with: .automatic)
                completion(true)
            }
            
        }
        return  UISwipeActionsConfiguration(actions: [action])
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {
           _,_,completion in
            self.model.deleteItem(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        return  UISwipeActionsConfiguration(actions: [action])
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.toogleItem(atIndex: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}
