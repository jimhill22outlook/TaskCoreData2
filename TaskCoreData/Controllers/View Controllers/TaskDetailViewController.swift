//
//  TaskDetailViewController.swift
//  TaskCoreData
//
//  Created by James Hill on 4/27/21.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    var task: Task?
    var date: Date?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
        //MARK: Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text, !name.isEmpty else { return }
        if let task = task {
            TaskController.sharedInstance.update(task: task, name: name, notes: taskNotesTextView.text, dueDate: date)
        } else {
            TaskController.sharedInstance.createTaskWith(name: name, notes: taskNotesTextView.text, dueDate: date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func dueDataPickerDateChanged(_ sender: Any) {
        self.date = taskDueDatePicker.date
    }
    
    func updateViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.note
        taskDueDatePicker.date = task.dueDate ?? Date()
    }
}
