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
    /// Only a single selection will be visible. All other sections will be closed.
    var singleSelectionOnly: Bool { get }
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

private struct Instruction<T: CollapsibleTableSectionDatasource> {
    let datasource: T
    let sectionIndex: Int
    let animation: UITableViewRowAnimation
    let indexPaths: [IndexPath]
    init(datasource: T, sectionIndex: Int, animation: UITableViewRowAnimation) {
        self.datasource = datasource
        self.sectionIndex = sectionIndex
        self.animation = animation
        indexPaths = datasource.rows.count.loop {
            IndexPath(row: $0, section: sectionIndex)
        }
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
        beginUpdates()
        for instruction in makeInstructions(selectedSectionIndex: sectionIndex) {
            switch instruction.datasource.state {
            case .collapsed:
                (headerView(forSection: instruction.sectionIndex) as? HeaderFooterViewCollapsible)?.open(animated: true)
                insertRows(at: instruction.indexPaths, with: instruction.animation)
                instruction.datasource.state = .expanded
            case .expanded:
                (headerView(forSection: instruction.sectionIndex) as? HeaderFooterViewCollapsible)?.close(animated: true)
                deleteRows(at: instruction.indexPaths, with: instruction.animation)
                instruction.datasource.state = .collapsed
            }
        }
        endUpdates()
    }
    
    private func makeInstructions(selectedSectionIndex: Int) -> [Instruction<TableSection>] {
        if singleSelectionOnly {
            return instructionsA(selectedSectionIndex)
        } else {
            return instructionsB(selectedSectionIndex)
        }
    }
    
    private func instructionsB(_ selectedSectionIndex: Int) -> [Instruction<TableSection>] {
        guard let dataSource = dataSource as? CollapsibleTableDatasource<TableSection>
            else { return [] }
        let section = dataSource.sections[selectedSectionIndex]
        return [Instruction(datasource: section, sectionIndex: selectedSectionIndex, animation: .top)]
    }
    
    private func instructionsA(_ selectedSectionIndex: Int) -> [Instruction<TableSection>] {
        guard let dataSource = dataSource as? CollapsibleTableDatasource<TableSection>
            else { return [] }
        var collector = [Instruction<TableSection>]()
        var openSectionFound = false
        for (index, section) in dataSource.sections.enumerated() {
            if index == selectedSectionIndex {
                var animation: UITableViewRowAnimation!
                if openSectionFound == true {
                    animation = (index == 0) ? .top : .bottom
                } else {
                    animation = (index == 0) ? .top : .middle
                }
                let instruction = Instruction(datasource: section, sectionIndex: index, animation: animation)
                collector.append(instruction)
                continue
            }
            if case .expanded = section.state {
                if openSectionFound == false {
                    openSectionFound = true
                }
                if index < selectedSectionIndex {
                    let animation: UITableViewRowAnimation = (index == 0) ? .top : .middle
                    let instruction = Instruction(datasource: section, sectionIndex: index, animation: animation)
                    collector.append(instruction)
                } else {
                    let animation: UITableViewRowAnimation = .bottom
                    let instruction = Instruction(datasource: section, sectionIndex: index, animation: animation)
                    collector.append(instruction)
                }
            }
        }
        return collector
    }
}
