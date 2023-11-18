//
//  Model.swift
//  ToDoList
//
//  Created by Эля Корельская on 27.10.2023.
//

import Foundation

class ToDoItem: Codable {
    
    var title: String
    var date: Date
    var isCompleted: Bool
    
    init(title: String, date: Date, isCompleted: Bool) {
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
    }
    
}
class Model {
    
    var items: [ToDoItem] = []
    
    init() {
        loadData()
    }
    /// добавление ячейки
    func addItem(title:String) {
        items.append(ToDoItem(title: title, date: Date(), isCompleted: false))
        saveData()
        
    }
    /// удаление ячейки
    func deleteItem(atIndex index: Int) {
        items.remove(at: index)
        saveData()
    }
    /// измнение ячейки
    func removeItem(atIndex index: Int, newTitle: String) {
        items[index].title = newTitle
        saveData()
    }
    /// смена значения ячейки
    func toogleItem(atIndex index: Int) {
        items[index].isCompleted.toggle()
        saveData()
    }
    /// создаем путь до локальной папки
    let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0].appending(path: "database.png")
    /// кодируем данные для сохранения (codable)
    private func saveData() {
       let data = try? JSONEncoder().encode(items)
        try? data?.write(to: url)
        
    }
    /// подгружаем данные декодируя их из локальной папки
    private func loadData() {
        if let data = try? Data(contentsOf: url) {
            items = (try? JSONDecoder().decode([ToDoItem].self, from: data)) ?? []
        }
            
    }
    
}
