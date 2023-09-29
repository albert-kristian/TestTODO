//
//  RealmService.swift
//  TestTODO
//
//  Created by Albert Kristian on 22.09.2023.
//

import Foundation
import Combine
import RealmSwift

class RealmService: DataService {

    private var mRealm: Realm?

    init(realm: Realm? = nil) {
        do {
            Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 1)
            try mRealm = realm ?? Realm()
        } catch {
            print("Error while trying to open Realm: \(error)")
        }
    }

    func fetchData() -> AnyPublisher<[TodoModel], Error> {
        return Future { promise in
            if let realm = self.mRealm {
                var todos: [TodoModel] = []
                realm.objects(RealmTodoModel.self).forEach({ realmTodo in
                    todos.append(realmTodo)
                })

                if !todos.isEmpty {
                    promise(.success(todos))
                } else {
                    promise(.failure("Data is empty"))
                }
            }
        }.eraseToAnyPublisher()
    }

    func delete(todo: TodoModel) -> VoidPublisher {
        return Future { promise in
            if let realm = self.mRealm {
                guard let realmTodo = todo as? RealmTodoModel else {
                    promise(.failure("Error while performing delete: object is not RealmTodoModel"))
                    return
                }
                do {
                    try realm.write {
                        realm.delete(realmTodo)
                        promise(.success(()))
                    }
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    func add(todo: TodoModel) -> VoidPublisher {
        return Future { promise in
            if let realm = self.mRealm {
                guard let realmTodo = todo as? RealmTodoModel else {
                    promise(.failure("Error while performing add: object is not RealmTodoModel"))
                    return
                }
                do {
                    try realm.write {
                        realm.add(realmTodo)
                        promise(.success(()))
                    }
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    func edit(itemId id: String, content: String?, isChecked: Bool?, dateTime: Date?) -> VoidPublisher {
        return Future { promise in
            if let realm = self.mRealm {
                do {
                    try realm.write {
                        guard var realmTodo = realm.object(ofType: RealmTodoModel.self, forPrimaryKey: id) else {
                            promise(.failure("Failed to find item by given id: \(id)"))
                            return
                        }
                        realmTodo.content = content ?? realmTodo.content
                        realmTodo.isChecked = isChecked ?? realmTodo.isChecked
                        realmTodo.dateTime = dateTime ?? realmTodo.dateTime
                        promise(.success(()))
                    }
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
