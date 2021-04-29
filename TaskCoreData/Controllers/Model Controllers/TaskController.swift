//
//  TaskController.swift
//  TaskCoreData
//
//  Created by James Hill on 4/27/21.
//

import CoreData

class TaskController {
    //MARK: Properties
    static let sharedInstance = TaskController()
    
    var tasks: [Task] = []

    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    //MARK: Functions
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        Task(name: name, notes: notes, dueDate: dueDate)
        CoreDataStack.saveContext()
    }
    
    func fetchTask() {
            tasks = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
    }
    
    func update(task: Task, name: String, notes:String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        CoreDataStack.saveContext()
    }
}//End of Class


