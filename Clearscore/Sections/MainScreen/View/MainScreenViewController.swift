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
    @IBOutlet var loadingView: UIView!
    @IBOutlet var circularScoreView: CircleView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var maximumScoreLabel: UILabel!

    init(viewModel vm: MainScreenViewModel) {
        viewModel = vm
        super.init(nibName: "MainScreenViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.inputs.onDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputs.onWillAppear()
    }
    
    private func setupUI() {
        circularScoreView.baseColor = UIColor.darkGray
        circularScoreView.tintColor = UIColor.red
        circularScoreView.strokeWidth = 4
    }
    
    private func setupBindings() {
        _ = viewModel.outputs.showError.sink(receiveValue: showErrorHandler(_:))
        _ = viewModel.outputs.vmStateUpdated.sink(receiveValue: stateUpdatedHandler(_:))
    }
    
    private func showErrorHandler(_ errorDescription: String) {
        let alertController = UIAlertController(title: "Error", message: "errorDescription", preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
    }
    
    private func stateUpdatedHandler(_ state: MainScreenViewModelState) {
        loadingView.isHidden = true
        
        switch state.state.status {
        case .idle:
            updateDoughnutForCredit(state.state.credit)
        default:
            break
        }
    }
    
    private func updateDoughnutForCredit(_ credit: Credit?) {
        guard let credit = credit else { return }
        let progress = MainScreenViewModelImpl.calculateDoughtnutProgress(forCredit: credit)
        circularScoreView.progress = CGFloat(progress)
        scoreLabel.text = MainScreenViewModelImpl.getScoreText(forCredit: credit)
        maximumScoreLabel.text = MainScreenViewModelImpl.getMaximumScoreText(forCredit: credit)
    }
}
