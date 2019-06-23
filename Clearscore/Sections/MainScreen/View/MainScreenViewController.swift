//
//  MainScreenViewController.swift
//  Clearscore
//
//  Created by Nuno Salvador on 23/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import UIKit
import Combine

class MainScreenViewController: UIViewController {
    private let viewModel: MainScreenViewModel
    
    init(viewModel vm: MainScreenViewModel) {
        viewModel = vm
        super.init(nibName: "MainScreenViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = viewModel.outputs.showError.sink { [weak self] errorDescription in
            let alertController = UIAlertController(title: "Error", message: "errorDescription", preferredStyle: .alert)
            self?.present(alertController, animated: true, completion: nil)
        }
        
        _ = viewModel.outputs.vmStateUpdated.sink(receiveValue: stateUpdatedHandler(_:))
    }
    
    private func stateUpdatedHandler(_ state: MainScreenViewModelState) {
        switch state.state.status {
        case .idle:
            // TODO: read credit and do ui stuffs
            break
        default:
            break
        }
    }
}
