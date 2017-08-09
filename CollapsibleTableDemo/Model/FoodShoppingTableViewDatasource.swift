//
//  FoodShoppingTableViewDatasource.swift
//  CollapsibleTableDemo
//
//  Created by Robert Nash on 09/08/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

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
