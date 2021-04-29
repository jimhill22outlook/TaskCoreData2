//
//  TaskListTableTableViewController.swift
//  TaskCoreData
//
//  Created by James Hill on 4/27/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TaskController.sharedInstance.fetchTask()
        tableView.reloadData()
    
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedInstance.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as?
            TaskTableViewCell else { return UITableViewCell() }
                
            let task = TaskController.sharedInstance.tasks[indexPath.row]

        cell.delegate = self
        cell.task = task
        
        return cell
    }
    // MARK: - Navigation
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskDetailViewController else { return }
            let task = TaskController.sharedInstance.tasks[indexPath.row]
            destination.task = task
        }
    }
}//End of Class

extension TaskListTableViewController: TaskCompletionDelegate {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let task = sender.task else { return }
        TaskController.sharedInstance.toggleIsComplete(task: task)
        sender.updateViews()
    }
}
