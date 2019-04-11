//  Created by @marciovcampos

import UIKit

struct Todo: Codable {
    let id: Int?
    let task: String
    var isCompleted: Bool
    
    init(task:String, id: Int?){
        self.id = id
        self.task = task
        self.isCompleted = false
    }
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var tableView: UITableView!
    let todoRepository = TodoRepository(network: NetworkService(baseUrl: "https://puc-dam-todolist.herokuapp.com"), token: "D8/2CBfbq0WFKc1ktFiNN+fBb1xTwp99GL3kKYq8y5k=")
    
    var items: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoRepository.all{ (result) in
            switch result{
                case .success(let todos):
                    self.items = todos
                    self.tableView.dataSource = self
                    self.tableView.delegate = self
                    self.tableView.register(TodoItemCell.self, forCellReuseIdentifier: "todoItem")
                case .error:
                    self.items.removeAll(keepingCapacity: false)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoItem", for: indexPath) as? TodoItemCell else { fatalError()}
        
        cell.textLabel?.text = items[indexPath.row].task
        cell.isCompleted = items[indexPath.row].isCompleted
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let removeAction = UIContextualAction(
            style: .destructive,
            title: "Excluir",
            handler: {(action, view, completionHandler) in
                
                self.todoRepository.delete(id: self.items[indexPath.row].id!) { (result) in
                    switch result{
                        case .success:
                            self.items.remove(at: indexPath.row)
                            self.tableView.reloadData()
                        case .error:
                            self.items.removeAll(keepingCapacity: false)
                    }
                    
                    completionHandler(true)
                }
            })
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [removeAction])
        
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let removeAction = UIContextualAction(
            style: .normal,
            title: self.items[indexPath.row].isCompleted ? "Cancelar" : "Concluir",
            handler: {(action, view, completionHandler) in
                
                self.todoRepository.toggleComplete(id: self.items[indexPath.row].id!, callback: { (result) in
                    switch result{
                        case .success(let todo):
                            self.items.remove(at: indexPath.row)
                            self.items.insert(todo, at: indexPath.row)
                            self.tableView.reloadRows(at: [indexPath], with: .fade)
                        case .error:
                            self.items.removeAll(keepingCapacity: false)
                    }
                    
                    completionHandler(true)
                })
                
        })
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [removeAction])
        
        return swipeConfiguration
    }
    
    
    @IBAction func adicionarItem(_ sender: Any) {
        let alertController = UIAlertController(title: "Criar Tarefa", message: "Digite a nova tarefa", preferredStyle: .alert)
        
        alertController.addTextField {
            (textField) in textField.placeholder = "Descrição"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            _ in guard let task = alertController.textFields?.first?.text else { return }
            
            self.todoRepository.create(taskTitle: task, callback: { (result) in
                switch result{
                    case .success(let todo):
                        self.items.append(todo)
                        self.tableView.reloadData()
                    case .error:
                        self.items.removeAll(keepingCapacity: false)
                }
            })
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

}

