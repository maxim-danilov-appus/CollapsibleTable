//
//  Constants.swift
//  CollapsibleTableDemo
//
//  Created by Robert Nash on 09/08/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import Foundation

enum Constants: String
{
    case ArrowSectionHeaderView
    
    var reuseIdentifier: String {
        return self.rawValue + "ID"
    }
}

