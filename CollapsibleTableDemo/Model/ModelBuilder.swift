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
    static func makeFoods(_ value: String? = nil) -> [Food] {
        guard let value = value else {
            return [makeFruit(), makeMeats(), makeVegetables()]
        }
        let instructions = value.split(separator: ",").map {
            return String($0) == "1" ? true : false
        }
        guard instructions.count == 3 else {
            fatalError("invalid instruction")
        }
        let fruits = makeFruit(instructions[0])
        let meats = makeMeats(instructions[1])
        let vegetables = makeVegetables(instructions[2])
        return [fruits,meats,vegetables]
    }
    
    private static func makeFruit(_ isHidden: Bool? = nil) -> Food {
        let items = [
            Item(title: "Banana"),
            Item(title: "Cherry"),
            Item(title: "Kiwi"),
            Item(title: "Grape")
        ]
        return Food(title: "Fruit", items: items, isHidden: isHidden ?? false)
    }
    
    private static func makeMeats(_ isHidden: Bool? = nil) -> Food {
        let items = [
            Item(title: "Lamb"),
            Item(title: "Chicken"),
            Item(title: "Beef")
        ]
        return Food(title: "Meats", items: items, isHidden: isHidden ?? true)
    }
    
    private static func makeVegetables(_ isHidden: Bool? = nil) -> Food {
        let items = [
            Item(title: "Cabbage"),
            Item(title: "Carrot"),
            Item(title: "Pea"),
            Item(title: "Asparagus"),
            Item(title: "Courgette")
        ]
        return Food(title: "Vegetables", items: items, isHidden: isHidden ?? false)
    }
}
