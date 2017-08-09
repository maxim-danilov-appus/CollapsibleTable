/**
 *  CollapsibleTable - Collapsible table view sections with custom section header views.
 *
 *  TableCollapsible.swift
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

public protocol TableCollapsible: class
{
    associatedtype TableSection: CollapsibleTableSectionDatasource
    func observeSectionHeaders()
    func sectionHeaderTapRecognized(by view: HeaderFooterViewCollapsible, at point: CGPoint)
    func stopObservingSectionHeaders()
}

public extension TableCollapsible
{
    func observeSectionHeaders() {
        NotificationCenter.default.addObserver(forName: .headerViewTapGestureRecognized, object: nil, queue: nil) { [weak self] (notification) in
            guard let point = notification.userInfo?[Constants.point] as? CGPoint, let view = notification.object as? HeaderFooterViewCollapsible
                else { return }
            self?.sectionHeaderTapRecognized(by: view, at: point)
        }
    }
    
    func stopObservingSectionHeaders() {
        NotificationCenter.default.removeObserver(self)
    }
}

public extension TableCollapsible where Self: UITableView
{
    func sectionHeaderTapRecognized(by view: HeaderFooterViewCollapsible, at point: CGPoint) {
        guard let headerView = view as? UITableViewHeaderFooterView, let sectionIndex = section(for: headerView)
            else { return }
        sectionHeaderTapRecognized(by: view, for: sectionIndex)
    }
    
    private func sectionHeaderTapRecognized(by view: HeaderFooterViewCollapsible, for sectionIndex: Int) {
        guard let dataSource = dataSource as? CollapsibleTableDatasource<TableSection>
            else { return }
        let section = dataSource.sections[sectionIndex]
        let indexPaths = section.rows.count.loop {
            IndexPath(row: $0, section: sectionIndex)
        }
        beginUpdates()
        switch section.state {
        case .collapsed:
            view.open(animated: true)
            insertRows(at: indexPaths, with: .top)
            section.state = .expanded
        case .expanded:
            view.close(animated: true)
            deleteRows(at: indexPaths, with: .top)
            section.state = .collapsed
        }
        endUpdates()
    }
}
