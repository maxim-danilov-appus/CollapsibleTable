//
//  Food.swift
//  CollapsibleTableDemo
//
//  Created by Robert Nash on 09/08/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import Foundation
import CollapsibleTable

class Food
{
    /// The section title
    fileprivate let title: String
    
    /// The rows
    fileprivate var items: [Item]
    
    /// Are rows hidden
    fileprivate var isHidden = false
    
    init(title: String, items: [Item], isHidden: Bool) {
        self.title = title
        self.items = items
        self.isHidden = isHidden
    }
}

extension Food: CollapsibleTableSectionDatasource
{
    typealias TableRow = Item
    
    var rows: [Item] {
        get {
            return items
        }
        set(newValue) {
            items = newValue
        }
    }
    
    var state: RowVisibility {
        get {
            return isHidden ? .collapsed : .expanded
        }
        set(newValue) {
            switch newValue {
            case .collapsed:
                isHidden = true
            case .expanded:
                isHidden = false
            }
        }
    }
    
    var sectionTitle: String {
        return title
    }
    
    var sectionHeaderNibName: String {
        let name = Constants.ArrowSectionHeaderView
        return name.rawValue
    }
    
    var sectionHeaderViewIdentifier: String {
        let name = Constants.ArrowSectionHeaderView
        return name.reuseIdentifier
    }
    
    var sectionHeaderNibBundle: Bundle {
        return .main
    }
}
