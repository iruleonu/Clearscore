//
//  MainScreenBuilder.swift
//  Clearscore
//
//  Created by Nuno Salvador on 23/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import UIKit

// Actions available from childs built from PostsListChildBuilders
enum MainScreenAction {
    // Empty
}

protocol MainScreenBuilderChildBuilders {
    // Empty
}

struct MainScreenBuilder {
    func make(network: APIFetchScoreProtocol) -> UIViewController {
        let coordinator = MainScreenCoordinator(builders: self, network: network)
        let vm = MainScreenViewModelImpl(routing: coordinator, network: network)
        return MainScreenViewController(viewModel: vm)
    }
}

extension MainScreenBuilder: MainScreenBuilderChildBuilders {
    
}
