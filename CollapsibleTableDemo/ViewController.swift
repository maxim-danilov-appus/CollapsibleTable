//
//  ViewController.swift
//  CollapsibleTableDemo
//
//  Created by Robert Nash on 09/08/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit
import CollapsibleTable

class ViewController: UIViewController
{
    @IBOutlet private weak var tableView: FoodShoppingTableView! {
        didSet {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            tableView.dataSource = appDelegate?.foodShoppingTableViewDatasource
            tableView.delegate = appDelegate?.foodShoppingTableViewDelegate
        }
    }
}
