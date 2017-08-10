//
//  CollapsibleTableTests.swift
//  CollapsibleTableTests
//
//  Created by Robert Nash on 10/08/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import XCTest
import UIKit
import CollapsibleTable

class CollapsibleTableTests: XCTestCase {
    
    func testRetainCountTableCollapsible() {
        var tableView: TableView? = TableView()
        weak var weakTableView = tableView
        tableView = nil
        XCTAssert(weakTableView == nil)
    }
    
    private class TableView: UITableView, TableCollapsible
    {
        typealias TableSection = Food
        
        init() {
            super.init(frame: .zero, style: .grouped)
            observeSectionHeaders()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        deinit {
            stopObservingSectionHeaders()
        }
    }
    
    private class Food: CollapsibleTableSectionDatasource
    {
        var state: RowVisibility = .expanded
        
        var rows: [String] {
            get {
                return []
            }
            set {
                
            }
        }
        
        typealias TableRow = String
        
        var sectionTitle: String {
            return "Title"
        }
        
        var sectionHeaderViewIdentifier: String {
            return ""
        }
        
        var sectionHeaderNibName: String {
            return ""
        }
        
        var sectionHeaderNibBundle: Bundle {
            return .main
        }
    }
}
