//
//  UserDefaultsService.swift
//  TestTODO
//
//  Created by Albert Kristian on 23.09.2023.
//

import Foundation
import Combine
import CoreData

class CoreDataService: DataService {

    let container = NSPersistentContainer(name: "CoreDataTodoModel")
        var context: NSManagedObjectContext {
            return container.viewContext
        }

        init() {
            self.container.loadPersistentStores { _, error in
                if let error = error {
                    fatalError("Unable to load persistent container: \(error.localizedDescription)")
                }
            }
        }

    func fetchData() -> TypedPublisher<[TodoModel]> {
        return Future { promise in
            let request = Todo.fetchRequest()

            do {
                let result = try self.context.fetch(request)
                promise(.success(result))
            } catch {
                promise(.failure("Failed to fetch data: \(error)"))
            }
        }.eraseToAnyPublisher()
    }

    func delete(todo: TodoModel) -> VoidPublisher {
        return Future { promise in
            if let todoObject = todo as? NSManagedObject {
                self.context.delete(todoObject)
                self.saveChanges()
                promise(.success(()))
            } else {
                promise(.failure("Failed to parse TodoModel as NSManagedObject"))
            }
        }.eraseToAnyPublisher()
    }

    func add(todo: TodoModel) -> VoidPublisher {
        return Future { promise in
            var todoObject: TodoModel = Todo(context: self.context)
            self.changeValues(
                oldTodo: &todoObject,
                id: todo.id,
                content: todo.content,
                isChecked: todo.isChecked,
                dateTime: todo.dateTime
            )
            self.saveChanges()
            promise(.success(()))
        }.eraseToAnyPublisher()
    }

    func edit(itemId id: String, content: String?, isChecked: Bool?, dateTime: Date?) -> VoidPublisher {
        return Future { promise in
            let request = Todo.fetchRequest()
            request.predicate = NSPredicate(format: "id = %@", id)

            do {
                if var result: TodoModel = try self.context.fetch(request).first {
                    self.changeValues(
                        oldTodo: &result,
                        id: id,
                        content: content,
                        isChecked: isChecked,
                        dateTime: dateTime
                    )
                    self.saveChanges()
                    promise(.success(()))
                } else {
                    throw "File with such id doesn't exist"
                }
            } catch {
                promise(.failure("Failed to fetch data: \(error)"))
            }
        }.eraseToAnyPublisher()
    }

    private func saveChanges() {
        do {
            try context.save()
        } catch {
            context.rollback()
            print("Failed to save task with CoreData: \(error.localizedDescription)")
        }
    }

    private func changeValues(
        oldTodo: inout TodoModel,
        id: String? = nil,
        content: String? = nil,
        isChecked: Bool? = nil,
        dateTime: Date? = nil
    ) {
        oldTodo.id = id ?? oldTodo.id
        oldTodo.content = content ?? oldTodo.content
        oldTodo.isChecked = isChecked ?? oldTodo.isChecked
        oldTodo.dateTime = dateTime ?? oldTodo.dateTime
    }
}
