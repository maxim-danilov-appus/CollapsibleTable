# CollapsibleTable

[![Carthage compatible](https://img.shields.io/badge/carthage-compatible-green.svg)](https://github.com/Carthage/Carthage)
[![Cocoapods compatible](https://img.shields.io/badge/cocoapods-compatible-green.svg)]()
[![Platform](https://img.shields.io/badge/platform-iOS%208%2B-blue.svg)]()
[![Language](https://img.shields.io/badge/language-swift%203.2%2B-blue.svg)]()
[![Build Status](https://travis-ci.org/rob-nash/CollapsibleTable.svg?branch=master)](https://travis-ci.org/rob-nash/CollapsibleTable)

The collapsing mechanism can be installed in just a few minutes. But the creative design and styling of the UI, is at the mercy of the implementing developer. The API expects you to use auto-layout for your table view and its subviews.

![demo](Screenshots/demo.gif)

Take a look at the demo App by running the XCode scheme 'CollapsibleTableDemo'

## Installation

**CocoaPods:**

Add the line `pod "CollapsibleTable"` to your `Podfile`

**Carthage:**

Add the line `github "rob-nash/CollapsibleTable"` to your `Cartfile`

## Usage

First subclass **UITableViewHeaderFooterView**

```swift
import UIKit

class ArrowSectionHeaderView: UITableViewHeaderFooterView
{
    @IBOutlet fileprivate weak var mainTitleLabel: UILabel!
    
    @IBOutlet fileprivate weak var arrowImageView: UIImageView?
    
    fileprivate var isRotating = false
}
```

Then conform to the **HeaderFooterViewCollapsible** protocol

```swift
import CollapsibleTable

extension ArrowSectionHeaderView: HeaderFooterViewCollapsible
{
    func updateTitle(with value: String) {
        mainTitleLabel.text = value
    }
    
    func open(animated: Bool) {
        if animated == true && isRotating == false {
            isRotating = true
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear,.allowUserInteraction], animations: {
                self.arrowImageView?.transform = .identity
            }, completion: { _ in
                self.isRotating = false
            })
        } else {
            layer.removeAllAnimations()
            arrowImageView?.transform = .identity
            isRotating = false
        }
    }
    
    func close(animated: Bool) {
        let angle = radians(degrees: 90)
        let transform = CGAffineTransform(rotationAngle: angle)
        if animated == true && isRotating == false {
            isRotating = true
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear,.allowUserInteraction], animations: {
                self.arrowImageView?.transform = transform
            }, completion: { _ in
                self.isRotating = false
            })
        } else {
            layer.removeAllAnimations()
            arrowImageView?.transform = transform
            isRotating = false
        }
    }

    private func radians(degrees: CGFloat) -> CGFloat {
        return .pi * degrees / 180
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let t = touches.first else { return }
        let point = t.location(in: self)
        respondToTouchAtPoint(point)
    }
}
```

Create a collection of instances that represent each section of your table view.

```swift
import Foundation

class Food
{
    /// The section title
    fileprivate let title: String
    
    /// The rows
    fileprivate var items: [Item]
    
    /// Are rows hidden
    fileprivate var isHidden = false
    
    init(title: String, items: [Item], isHidden: Bool) {
        self.title = title
        self.items = items
        self.isHidden = isHidden
    }
}

class Item
{
    let title: String
    var isSelected: Bool
    
    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}
```

Each model instance representing your table view sections, must conform to **CollapsibleTableSectionDatasource**.

```swift
extension Food: CollapsibleTableSectionDatasource
{
    typealias TableRow = Item
    
    var rows: [Item] {
        get {
            return items
        }
        set(newValue) {
            items = newValue
        }
    }
    
    var state: RowVisibility {
        get {
            return isHidden ? .collapsed : .expanded
        }
        set(newValue) {
            switch newValue {
            case .collapsed:
                isHidden = true
            case .expanded:
                isHidden = false
            }
        }
    }
    
    var sectionTitle: String {
        return title
    }
    
    var sectionHeaderNibName: String {
        return "ArrowSectionHeaderView"
    }
    
    var sectionHeaderViewIdentifier: String {
        return "ArrowSectionHeaderViewID"
    }
    
    var sectionHeaderNibBundle: Bundle {
        return .main
    }
}
```

Create a UITableView subclass that conforms to **TableCollapsible**.

```swift
import UIKit
import CollapsibleTable

class FoodShoppingTableView: UITableView, TableCollapsible
{
    typealias TableSection = Food
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        separatorStyle = .none
        let nib = UINib(nibName: "ArrowSectionHeaderView", bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: "ArrowSectionHeaderViewID")
        observeSectionHeaders()
    }
    
    deinit {
        stopObservingSectionHeaders()
    }
}
```

Create a datasource by subclassing CollapsibleTableDatasource<T>

```swift
import UIKit
import CollapsibleTable

class FoodShoppingTableViewDatasource: CollapsibleTableDatasource<Food>
{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        let section: Food = sections[indexPath.section]
        let item: Item = section.rows[indexPath.row]
        cell.mainTitleLabel?.text = item.title
        return cell
    }
}
```

Then connect it all up

```swift
import UIKit
import CollapsibleTable

class ViewController: UIViewController
{
    @IBOutlet private weak var tableView: FoodShoppingTableView! {
        didSet {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            tableView.dataSource = appDelegate?.foodShoppingTableViewDatasource
        }
    }
}
```

### Donations.
<p>If you like this and you want to buy me a drink, use bitcoin.</p>

![Bitcoin Image](Resources/Bitcoin.jpg)

Bitcoin Address: 15Gj4DBTzSujnJrfRZ6ivrR9kDnWXNPvNQ