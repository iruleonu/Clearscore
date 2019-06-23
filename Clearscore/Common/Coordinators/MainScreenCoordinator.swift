//
//  MainScreenCoordinator.swift
//  Clearscore
//
//  Created by Nuno Salvador on 23/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import UIKit

protocol MainScreenRouting {
    // empty
}

final class MainScreenCoordinator {
    private let builders: MainScreenBuilderChildBuilders
    private let network: APIFetchScoreProtocol
    
    init(builders b: MainScreenBuilderChildBuilders, network n: APIFetchScoreProtocol) {
        builders = b
        network = n
    }
}

extension MainScreenCoordinator: MainScreenRouting {
    
}
