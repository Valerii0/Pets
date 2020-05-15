//
//  BreedsViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class BreedsViewController: UIViewController, Storyboarded {

    var presenter: BreedsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closeViewController))
        //        navigationItem.leftBarButtonItem = cancel
        //
        //        let starImage = UIImage(named: "favorite")
        //        let starButton = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(favoriteTapped(sender:)))
        //        do {
        //            let realm = try Realm()
        //            let scope = realm.objects(TeamDB.self).filter("teamId == %@", teamDB.teamId)
        //            if scope.first != nil {
        //                starButton.tintColor = UIColor.orange
        //            } else {
        //                starButton.tintColor = UIColor.gray
        //            }
        //        } catch {
        //            print(error.localizedDescription)
        //        }
        //               navigationItem.rightBarButtonItem = starButton
            
        //    @objc private func favoriteTapped(sender: UIBarButtonItem) {
        //        if sender.tintColor == UIColor.orange {
        //            deleteTeamFromRealm(teamDB: teamDB)
        //            sender.tintColor = UIColor.gray
        //        } else if sender.tintColor == UIColor.gray {
        //            addTeamToRealm(teamDB: teamDB)
        //            sender.tintColor = UIColor.orange
        //        }
        //    }
        //
        //    @objc private func closeViewController() {
        //        dismiss(animated: true, completion: nil)
        //    }
    }
}

extension BreedsViewController: BreedsView {
}
