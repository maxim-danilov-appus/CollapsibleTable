/**
 *  CollapsibleTable - Collapsible table view sections with custom section header views.
 *
 *  CollapsableTableSectionDatasource.swift
 *
 *  For usage, see documentation of the classes/symbols listed in this file.
 *
 *  Copyright © 2017 Robert Nash. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

import Foundation

/// The row visibility of a given table view section.
///
/// - collapsed: There are zero rows
/// - expanded: There are >0 rows
public enum RowVisibility
{
    case collapsed
    case expanded
}

/// The datasource for a section header of a UITableView subclass
public protocol SectionHeaderDatasource: class
{
    /// The section title, typically displayed in a UILabel subview of a UITableViewHeaderFooterView subclass
    var sectionTitle: String { get }
    
    /// The identifier for dequeeing a registered UITableViewHeaderFooterView that conforms to HeaderFooterViewCollapsable
    var sectionHeaderViewIdentifier: String { get }
    
    /// The name of the nib file for your registered UITableViewHeaderFooterView
    var sectionHeaderNibName: String { get }
    
    /// The source bundle containing your registered UITableViewHeaderFooterView
    var sectionHeaderNibBundle: Bundle { get }
}

/// The datasource for a section of a UITableView subclass
public protocol CollapsibleTableSectionDatasource: SectionHeaderDatasource
{
    /// The type of value utilised as a datasource for each row
    associatedtype TableRow
    
    /// The visibility of the rows in this section
    var state: RowVisibility { get set }
    
    /// The datasource for each row
    var rows: [TableRow] { get set }
}
