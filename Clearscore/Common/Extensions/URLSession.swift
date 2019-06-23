//
//  URLSession.swift
//  IRShowcase
//
//  Created by Nuno Salvador on 21/03/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import Combine

extension URLSession {
    func fetchData(_ request: URLRequest) -> Publishers.Future<(Data, URLResponse), DataProviderError> {
        return Publishers.Future { promise in
            self.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    let httpResponse = response as? HTTPURLResponse
                    if let data = data, let httpResponse = httpResponse, 200..<300 ~= httpResponse.statusCode {
                        promise(Result.success((data, httpResponse)))
                    } else if let httpResponse = httpResponse {
                        promise(.failure(DataProviderError.requestError(httpStatusCode: httpResponse.statusCode, error: error)))
                    } else {
                        promise(.failure(.unknown))
                    }
                }
                }
                .resume()
        }
    }
}
