//
//  MainScreenViewModel.swift
//  Clearscore
//
//  Created by Nuno Salvador on 23/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import Combine

protocol MainScreenViewModelInputs {
    func onDidLoad()
    func onWillAppear()
}

protocol MainScreenViewModelOutputs {
    var vmStateUpdated: PassthroughSubject<MainScreenViewModelState, Never> { get }
    var showError: PassthroughSubject<String, Never> { get }
}

protocol MainScreenViewModel {
    var inputs: MainScreenViewModelInputs { get }
    var outputs: MainScreenViewModelOutputs { get }
}

final class MainScreenViewModelImpl: MainScreenViewModel, MainScreenViewModelInputs, MainScreenViewModelOutputs {
    private var routing: MainScreenRouting
    private var apiService: APIFetchScoreProtocol
    var inputs: MainScreenViewModelInputs { return self }
    var outputs: MainScreenViewModelOutputs { return self }
    var vmStateUpdated: PassthroughSubject<MainScreenViewModelState, Never>
    var showError: PassthroughSubject<String, Never>
    
    private var state: MainScreenViewModelState
    
    private var cancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    init(routing r: MainScreenRouting, network: APIFetchScoreProtocol) {
        routing = r
        apiService = network
        vmStateUpdated = PassthroughSubject<MainScreenViewModelState, Never>()
        showError = PassthroughSubject<String, Never>()
        state = MainScreenViewModelState()
    }
    
    func onDidLoad() {
        fetchCredit()
    }
    
    func onWillAppear() {
        // Do nothing
    }
    
    static func calculateDoughtnutProgress(forCredit: Credit) -> Float {
        let currentScore = forCredit.creditReportInfo.score
        let maximumScore = forCredit.creditReportInfo.maximumScore
        let progress = Float(currentScore / maximumScore)
        
        if progress >= 1.0 {
            return 1.0
        }
        
        if progress <= 0 {
            return 0.0
        }
        
        return progress
    }
    
    static func getScoreText(forCredit: Credit) -> String {
        return "\(forCredit.creditReportInfo.score)"
    }
    
    static func getMaximumScoreText(forCredit: Credit) -> String {
        return "out of \(forCredit.creditReportInfo.maximumScore)"
    }
    
    private func fetchCredit() {
        cancellable = apiService.fetchCredit()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.state.handleEvent(.didFail(error.errorDescription))
                    self.vmStateUpdated.send(self.state)
                    self.showError.send(error.errorDescription)
                case .finished:
                    self.vmStateUpdated.send(self.state)
                }
                }, receiveValue: { [weak self] credit in
                    guard let self = self else { return }
                    self.state.handleEvent(.didLoad(credit))
                    self.vmStateUpdated.send(self.state)
            })
    }
}
