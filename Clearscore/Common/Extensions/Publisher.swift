//
//  Publisher.swift
//  Clearscore
//
//  Created by Nuno Salvador on 23/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import Combine

extension Publisher {
    public func replaceError(
        replace: @escaping (Failure) -> Self.Output
        ) -> AnyPublisher<Self.Output, Never> {
        return `catch` { error in
            Publishers.Just(replace(error))
            }.eraseToAnyPublisher()
    }
    
    public func ignoreError() -> AnyPublisher<Output, Never> {
        return `catch` { _ in
            Publishers.Empty()
            }.eraseToAnyPublisher()
    }
}
