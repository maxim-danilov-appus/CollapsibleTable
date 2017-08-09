//
//  ModelBuilder.swift
//  CollapsibleTableDemo
//
//  Created by Robert Nash on 09/08/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import Foundation

struct ModelBuilder
{
    static func makeFoods() -> [Food] {
        return [makeFruit(), makeMeats(), makeVegetables()]
    }
    
    private static func makeFruit() -> Food {
        let items = [
            Item(title: "Banana"),
            Item(title: "Cherry"),
            Item(title: "Kiwi"),
            Item(title: "Grape")
        ]
        return Food(title: "Fruit", items: items, isHidden: false)
    }
    
    private static func makeMeats() -> Food {
        let items = [
            Item(title: "Lamb"),
            Item(title: "Chicken"),
            Item(title: "Beef")
        ]
        return Food(title: "Meats", items: items, isHidden: true)
    }
    
    private static func makeVegetables() -> Food {
        let items = [
            Item(title: "Cabbage"),
            Item(title: "Carrot"),
            Item(title: "Pea"),
            Item(title: "Asparagus"),
            Item(title: "Courgette")
        ]
        return Food(title: "Vegetables", items: items, isHidden: false)
    }
}
