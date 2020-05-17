//
//  SettingsViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, Storyboarded {
    @IBOutlet weak var settingsTableView: UITableView!
    
    var presenter: SettingsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
//        let yourBackImage = UIImage(named: "back_button_image")
//        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
//        self.navigationController?.navigationBar.backItem?.title = "Custom"
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        setUpTableView(tableView: settingsTableView)
    }
    
    private func setUpTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = CommonValues.standardGrayColor
        tableView.tableFooterView = UIView()
        //tableView.separatorStyle = .none
        //tableView.layer.cornerRadius = AppConstants.CommonConstants.learningCornerRadius
        tableView.register(UINib(nibName: SettingsConstants.userDataTableViewCell.rawValue, bundle: nil),
                           forCellReuseIdentifier: SettingsConstants.userDataTableViewCell.rawValue)
        tableView.register(UINib(nibName: SettingsConstants.appStateTableViewCell.rawValue, bundle: nil),
                           forCellReuseIdentifier: SettingsConstants.appStateTableViewCell.rawValue)
        tableView.register(UINib(nibName: SettingsConstants.keyTableViewCell.rawValue, bundle: nil),
                           forCellReuseIdentifier: SettingsConstants.keyTableViewCell.rawValue)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsСategories.allValues.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let settingsСategory = SettingsСategories(rawValue: section) else { return 0 }
        switch settingsСategory {
        case .userData:
            return UserData.allValues.count
        case .appState:
            return AppState.allValues.count
        case .info:
            return Info.allValues.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let settingsСategory = SettingsСategories(rawValue: indexPath.section) else { return UITableViewCell() }
        switch settingsСategory {
        case .userData:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsConstants.userDataTableViewCell.rawValue, for: indexPath) as! UserDataTableViewCell
            guard let userData = UserData(rawValue: indexPath.row) else { return cell }
            switch userData {
            case .liked:
                cell.configure(title: SettingsConstants.likedPic.rawValue)
            case .voted:
                cell.configure(title: SettingsConstants.votedPic.rawValue)
            case .highScore:
                cell.configure(title: SettingsConstants.highScore.rawValue)
            }
            return cell
        case .appState:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsConstants.appStateTableViewCell.rawValue, for: indexPath) as! AppStateTableViewCell
            guard let appState = AppState(rawValue: indexPath.row) else { return cell }
            switch appState {
            case .chooseSide:
                cell.configure(title: SettingsConstants.chooseSide.rawValue)
            case .logOut:
                cell.configure(title: SettingsConstants.logOut.rawValue)
            }
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsConstants.keyTableViewCell.rawValue, for: indexPath) as! KeyTableViewCell
            cell.configure(title: SettingsConstants.key.rawValue)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let settingsСategory = SettingsСategories(rawValue: indexPath.section) else { return 0 }
        switch settingsСategory {
        case .userData:
            return CommonValues.standartTableViewCellHeight
        case .appState:
            return CommonValues.standartTableViewCellHeight
        case .info:
            return CommonValues.standartTableViewCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let settingsСategory = SettingsСategories(rawValue: indexPath.section) else { return }
        switch settingsСategory {
        case .userData:
            guard let userData = UserData(rawValue: indexPath.row) else { return }
            switch userData {
            case .liked:
                presenter.pushLikedVotedViewController(state: .liked)
            case .voted:
                presenter.pushLikedVotedViewController(state: .voted)
            case .highScore:
                print("cell.configure(title: SettingsConstants.highScore.rawValue)")
            }
        case .appState:
            guard let appState = AppState(rawValue: indexPath.row) else { return }
            switch appState {
            case .chooseSide:
                presenter.chooseSide()
            case .logOut:
                print("cell.configure(title: SettingsConstants.logOut.rawValue)")
            }
        case .info:
            print("cell.configure(title: SettingsConstants.key.rawValue)")
        }
    }
}

extension SettingsViewController: SettingsView {
}
