//
//  MainScreenViewModelState.swift
//  Clearscore
//
//  Created by Nuno Salvador on 23/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation

final class MainScreenViewModelState {
    struct State {
        var credit: Credit?
        var status: Status
    }
    
    enum Status: Equatable {
        case loading
        case idle
        case failed(String)
    }
    
    enum Event {
        case didLoad(Credit)
        case didFail(String)
    }
    
    private(set) var state: State
    
    init() {
        state = State(credit: nil, status: Status.loading)
    }
    
    func handleEvent(_ event: Event) {
        state = MainScreenViewModelState.reducer(state: state, event: event)
    }
    
    private static func reducer(state: State, event: Event) -> State {
        switch event {
        case .didLoad(let credit):
            var copy = state
            
            copy.credit = credit
            copy.status = .idle
            
            return copy
        case .didFail(let error):
            var copy = state
            
            copy.status = .failed(error)
            
            return copy
        }
    }
}
