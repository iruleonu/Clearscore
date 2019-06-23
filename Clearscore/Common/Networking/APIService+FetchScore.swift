//
//  APIService+FetchScore.swift
//  Clearscore
//
//  Created by Nuno Salvador on 23/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import Combine

protocol APIFetchScoreProtocol {
    func fetchCredit() -> AnyPublisher<Credit, APIServiceError>
}

extension APIServiceImpl: APIFetchScoreProtocol {
    func fetchCredit() -> AnyPublisher<Credit, APIServiceError> {
        let properties = Resource.credit.requestProperties
        let urlRequest = URLRequest(url: apiBaseUrl.appendingPathComponent(properties.path))
        let parseData: ((Data, URLResponse)) -> Publishers.Future<Credit, APIServiceError> = { tuple in
            return Publishers.Future { promise in
                do {
                    let result = try JSONDecoder().decode(Credit.self, from: tuple.0)
                    promise(Result.success(result))
                } catch {
                    promise(.failure(APIServiceError.parsing(error: error)))
                }
            }
        }
        
        return session.fetchData(urlRequest)
            .mapError { APIServiceError.network(error: $0) }
            .flatMap(parseData)
            .eraseToAnyPublisher()
    }
}
