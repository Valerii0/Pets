//
//  SelectionPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol SelectionView: class {
}

protocol SelectionPresenterDelegate: class {
    func changeIndex(index: Int)
}

class SelectionPresenter {
    private weak var view: SelectionView?
    private var coordinator: MainCoordinator?
    private weak var delegate: SelectionPresenterDelegate?
    var dataSource = [String]()

    init(view: SelectionView, coordinator: MainCoordinator, delegate: SelectionPresenterDelegate, dataSource: [String]) {
        self.view = view
        self.coordinator = coordinator
        self.delegate = delegate
        self.dataSource = dataSource
    }
    
    func changeIndex(index: Int) {
        delegate?.changeIndex(index: index)
    }
}
