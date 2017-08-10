//
//  AppDelegate.swift
//  CollapsibleTableDemo
//
//  Created by Robert Nash on 09/08/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit
import CollapsibleTable

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    // foods must be a pointer so that it can be referenced in multiple locations
    let foods: [Food] = ModelBuilder.makeFoods()
    lazy var foodShoppingTableViewDatasource: FoodShoppingTableViewDatasource = {
        return FoodShoppingTableViewDatasource(sections: self.foods)
    }()
    lazy var foodShoppingTableViewDelegate: FoodShoppingTableViewDelegate = {
        return FoodShoppingTableViewDelegate(sections: self.foods)
    }()
}
