//
//  FoodShoppingTableView.swift
//  CollapsibleTableDemo
//
//  Created by Robert Nash on 09/08/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit
import CollapsibleTable

class FoodShoppingTableView: UITableView, TableCollapsible
{
    typealias TableSection = Food
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        separatorStyle = .none
        let name = Constants.ArrowSectionHeaderView
        let nib = UINib(nibName: name.rawValue, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: name.reuseIdentifier)
        observeSectionHeaders()
    }
    
    deinit {
        stopObservingSectionHeaders()
    }
}
