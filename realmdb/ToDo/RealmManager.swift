//
//  RealmManager.swift
//  ToDo
//
//  Created by Jessie sihota on 2022-07-18.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published var tasks: [Task] = []

    // On initialize of the class, we'll open a Realm and get the tasks saved in the Realm
    init() {
        openRealm()
        getTasks()
    }

    // Function to open a Realm (like a box) - needed for saving data inside of the Realm
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)

            Realm.Configuration.defaultConfiguration = config

            // Trying to open a Realm and saving it into the localRealm variable
            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }

    // Function to add a task
    func addTask(taskTitle: String) {
        if let localRealm = localRealm { // Need to unwrap optional, since localRealm is optional
            do {
                // Trying to write to the localRealm
                try localRealm.write {
                    // Creating a new Task
                    let newTask = Task(value: ["title": taskTitle, "completed": false])
                   
                    // Adding newTask to localRealm
                    localRealm.add(newTask)
                    
                    // Re-setting the tasks array
                    getTasks()
                    print("Added new task to Realm!", newTask)
                }
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
    
    // Function to get all tasks from Realm and setting them in the tasks array
    func getTasks() {
        if let localRealm = localRealm {
            
            let allTasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed")
            
            // Resetting the tasks array
            tasks = []
            
            // Append each task to the tasks array
            allTasks.forEach { task in
                tasks.append(task)
            }
        }
    }

    // Function to update a task's completed state
    func updateTask(id: ObjectId, completed: Bool) {
        if let localRealm = localRealm {
            do {
                let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
            
                guard !taskToUpdate.isEmpty else { return }

                // Trying to write to the localRealm
                try localRealm.write {
                    
                    taskToUpdate[0].completed = completed
                    
                    // Re-setting the tasks array
                    getTasks()
                    print("Updated task with id \(id)! Completed status: \(completed)")
                }
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }

    // Function to delete a task
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToDelete.isEmpty else { return }
                
                // Trying to write to the localRealm
                try localRealm.write {
                    
                    // Deleting the task
                    localRealm.delete(taskToDelete)
                    
                    // Re-setting the tasks array
                    getTasks()
                    print("Deleted task with id \(id)")
                }
            } catch {
                print("Error deleting task \(id) to Realm: \(error)")
            }
        }
    }
}


