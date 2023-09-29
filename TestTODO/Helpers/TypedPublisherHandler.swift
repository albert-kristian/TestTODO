//
//  TypedPublisherHandler.swift
//  TestTODO
//
//  Created by Albert Kristian on 23.09.2023.
//

import Foundation
import Combine

// Do not pay attention, just some practice to understand better how the things work :)
struct TypedPublisherHandler<T> {
    func handlePublisher(
        publisher: TypedPublisher<T>,
        completion: @escaping (T) -> Void
    ) -> Cancellable {
        return publisher.sink { completion in
            switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
            }
        } receiveValue: { value in
            completion(value)
        }
    }
}
