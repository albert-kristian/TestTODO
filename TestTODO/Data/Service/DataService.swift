//
//  DataService.swift
//  TestTODO
//
//  Created by Albert Kristian on 23.09.2023.
//

import Foundation
import Combine

typealias VoidPublisher = AnyPublisher<Void, Error>
typealias TypedPublisher<T> = AnyPublisher<T, Error>

protocol DataService {
    func fetchData() -> TypedPublisher<[TodoModel]>
    func delete(todo: TodoModel) -> VoidPublisher
    func add(todo: TodoModel) -> VoidPublisher
    func edit(itemId id: String, content: String?, isChecked: Bool?, dateTime: Date?) -> VoidPublisher
}
