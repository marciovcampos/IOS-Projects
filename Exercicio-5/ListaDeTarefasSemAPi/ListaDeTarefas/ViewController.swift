//  Created by @marciovcampos

import UIKit

struct Todo: Codable {
    let task: String
    var isCompleted: Bool
    
    init(task:String){
        self.task = task
        self.isCompleted = false
    }
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Todo] = [
        Todo(task: "Tarefa 1"),
        Todo(task: "Tarefa 2"),
        Todo(task: "Tarefa 3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(TodoItemCell.self, forCellReuseIdentifier: "todoItem")
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].isCompleted = items[indexPath.row].isCompleted ? false : true
        
        let itemTemp = self.items[indexPath.row]
        self.items.remove(at: indexPath.row)
        self.items.insert(itemTemp, at: indexPath.row)
        
        self.tableView.reloadRows(at: [indexPath], with: .fade)
     }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt  indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let remove = UIContextualAction(
            style: .destructive,
            title: "Excluir",
            handler: {(action, view, completionHandler) in
                
                self.items.remove(at: indexPath.row)
                self.tableView.reloadData()
                
                completionHandler(true)
        })
        
        return UISwipeActionsConfiguration(actions: [remove])
    
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let complete = UIContextualAction(
            style: .normal,
            title: self.items[indexPath.row].isCompleted ? "Cancelar" : "Concluir",
            handler: {(action, view, completionHandler) in
                
                self.items[indexPath.row].isCompleted = self.items[indexPath.row].isCompleted ? false : true
                
                let itemT = self.items[indexPath.row]
                self.items.remove(at: indexPath.row)
                self.items.insert(itemT, at: indexPath.row)
                tableView.reloadRows(at: [indexPath], with: .fade)
                
                completionHandler(true)
        })
        
        return UISwipeActionsConfiguration(actions: [complete])
        
    }
    
    @IBAction func adicionarItem(_ sender: Any) {
        let alert = UIAlertController(title: "Criar Tarefa", message: "Digite a nova tarefa", preferredStyle: .alert)
        
        alert.addTextField {
            (textField) in textField.placeholder = "Descrição"
        }
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: {
            _ in guard let task = alert.textFields?.first?.text else { return }
            
            self.items.append(Todo(task: task))
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }

}

