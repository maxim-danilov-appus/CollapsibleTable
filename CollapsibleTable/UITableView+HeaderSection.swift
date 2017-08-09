/**
 *  CollapsibleTable - Collapsible table view sections with custom section header views.
 *
 *  UITableView+HeaderSection.swift
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

import UIKit

extension UITableView {
    
    /// Establishes the section index for the supplied view, if any.
    ///
    /// - Parameter view: The view to find.
    /// - Returns: The section index of the section that has the view parameter.
    func section(for view: UITableViewHeaderFooterView) -> Int? {
        for i in 0..<numberOfSections {
            let a: CGPoint = convert(.zero, from: headerView(forSection: i))
            let b: CGPoint = convert(.zero, from: view)
            let isMatch = a.y == b.y
            if isMatch { return i }
        }
        return nil
    }
        
}
