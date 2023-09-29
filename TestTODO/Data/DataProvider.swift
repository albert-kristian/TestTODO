//
//  DataProvider.swift
//  TestTODO
//
//  Created by Albert Kristian on 20.09.2023.
//

import Foundation
import Combine

class DataProvider: ObservableObject {
    @Published var todoItems: [TodoModel] = [TodoModel]()

    private var dataService: DataService
    private var cancellables: [Cancellable] = []

    init(dataService: DataService? = nil) {
        self.dataService = dataService ?? RealmService()

        fetchData()
    }

    func switchService(service: Service) {
        switch service {
            case Service.realm:
                dataService = RealmService()
            case Service.coreData:
                dataService = CoreDataService()
        }
        fetchData()
    }

    func add(todo: TodoModel) {
        let cancellable = TypedPublisherHandler().handlePublisher(
            publisher: dataService.add(todo: todo),
            completion: {
                print("Added")
                self.fetchData()
            }
        )
        cancellables.append(cancellable)
    }

    func check(id: String) {
        guard let index = todoItems.firstIndex(where: { $0.id == id }) else {
            print("Item does not exist")
            return
        }

        let cancellable = TypedPublisherHandler().handlePublisher(
            publisher: dataService.edit(
                itemId: todoItems[index].id,
                content: nil,
                isChecked: !todoItems[index].isChecked,
                dateTime: nil
            ),
            completion: {
                print("Edited")
                self.fetchData()
            }
        )
        cancellables.append(cancellable)
    }

    func delete(todo: TodoModel) {
        let cancellable = TypedPublisherHandler().handlePublisher(
            publisher: dataService.delete(todo: todo),
            completion: {
                print("Deleted")
                self.fetchData()
            }
        )
        cancellables.append(cancellable)
    }

    func fetchData() {
        let cancellable = TypedPublisherHandler().handlePublisher(
            publisher: dataService.fetchData(),
            completion: { todos in
                self.todoItems = todos
            }
        )
        cancellables.append(cancellable)
    }

    deinit {
        cancellables.forEach({ cancellable in
            cancellable.cancel()
        })
    }
}

enum Service {
    case realm
    case coreData
}
