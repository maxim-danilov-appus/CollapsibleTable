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
    var foodShoppingTableViewDatasource: FoodShoppingTableViewDatasource?
    var foodShoppingTableViewDelegate: FoodShoppingTableViewDelegate?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        // foods must be a pointer so that it can be referenced in multiple locations
        let foods: [Food] = makeFoods()
        foodShoppingTableViewDelegate = FoodShoppingTableViewDelegate(sections: foods)
        foodShoppingTableViewDatasource = FoodShoppingTableViewDatasource(sections: foods)
        return true
    }
    
    private func makeFoods() -> [Food] {
        let foods: [Food]
        if CommandLine.arguments.contains("--uitesting") {
            let argument = CommandLine.arguments[2]
            let components = argument.split(separator: ":")
            let code = components.dropFirst().joined(separator: ",")
            foods = ModelBuilder.makeFoods(code)
        } else {
            foods = ModelBuilder.makeFoods()
        }
        return foods
    }
}
