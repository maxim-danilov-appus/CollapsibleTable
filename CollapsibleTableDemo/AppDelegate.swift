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
    var foodShoppingTableViewModel: FoodShoppingTableViewModel?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        foodShoppingTableViewModel = FoodShoppingTableViewModel(sections: makeFoods())
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
