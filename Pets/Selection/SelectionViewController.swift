//
//  SelectionViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController, Storyboarded {
    @IBOutlet weak var selectionTableView: UITableView!
    
    var presenter: SelectionPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        customBackButton()
        
        setUpSelectionTableView(tableView: selectionTableView)
    }
    
    private func setUpSelectionTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = CommonValues.standardGrayColor
        tableView.tableFooterView = UIView()
        //filterTableView.separatorStyle = .none
        tableView.register(UINib(nibName: SelectionConstants.selectionTableViewCell.rawValue, bundle: nil),
                                 forCellReuseIdentifier: SelectionConstants.selectionTableViewCell.rawValue)
    }
}

extension SelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionConstants.selectionTableViewCell.rawValue, for: indexPath) as! SelectionTableViewCell
        cell.configure(title: presenter.dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommonValues.standartTableViewCellHeight
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .clear
//        return view
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.changeIndex(index: indexPath.row)
    }
}

extension SelectionViewController: SelectionView {
}
