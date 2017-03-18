//
//  CellType.swift
//  EventOMat
//
//  Created by Louis Franco on 2/11/17.
//  Copyright © 2017 Lou Franco. All rights reserved.
//

import Foundation
import UIKit

enum CellType {
    case largeText(text: String)
    case navigation(text: String, imageName: String, navigate: () -> Void)
    case schedule(item: ScheduleItem)
}

extension CellType {

    func reuseIdentifier() -> String {
        switch self {
        case .largeText:
            return "LargeTextCell"
        case .navigation:
            return "NavigationCell"
        case .schedule:
            return "ScheduleCell"
        }
    }

    func configure(cell: UITableViewCell) {
        switch self {
        case .navigation(let text, let imageName, _):
            guard let cell = cell as? NavigationCell else { return }
            cell.label.text = text
            cell.icon.image = UIImage(named: imageName)
            cell.icon.tintColor = UIColor.lightGray

        case .largeText(let text):
            guard let cell = cell as? LargeTextCell else { return }
            cell.label.text = text

        case .schedule(let item):
            guard let cell = cell as? ScheduleCell else { return }
            cell.session.text = item.session
            cell.room.text = item.room
            cell.color.backgroundColor = item.type.color()
        }
    }

    func makeCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier(), for: indexPath)

        self.configure(cell: cell)

        return cell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = makeCell(tableView: tableView, indexPath: indexPath) else {
            fatalError("Unexpected type of cell.")
        }
        cell.isSelected = false

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self {
        case .largeText:
            // The cells with large text need to be taller.
            return 88

        case .navigation:
            // Navigation cells are the default size.
            return UITableViewAutomaticDimension

        case .schedule:
            // Schedule cells depend on the content of the session text, which is controlled by constraints.
            return UITableViewAutomaticDimension
        }
    }

}

class CellViewable: NSObject, UITableViewDelegate, UITableViewDataSource {

    let viewController: UIViewController
    let cells: [[CellType]]

    typealias SectionHeaderFn = (([CellType]) -> String)
    let sectionHeaderForCells: SectionHeaderFn?

    init(viewController: UIViewController, cells: [[CellType]], sectionHeaderForCells: SectionHeaderFn? = nil) {
        self.viewController = viewController
        self.cells = cells
        self.sectionHeaderForCells = sectionHeaderForCells
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionHeaderForCells = sectionHeaderForCells, section < cells.count else {
            return nil
        }
        return sectionHeaderForCells(cells[section])
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }

    // This function is called when the app wants to know how many rows the table has.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }

    // This function is called to get the contents of a cell when needed.
    func tableView(_ tableView: UITableView, cellForRowAt cellForRowAtIndexPath: IndexPath) -> UITableViewCell {
        return cells[cellForRowAtIndexPath.section][cellForRowAtIndexPath.row].tableView(tableView, cellForRowAt: cellForRowAtIndexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt heightForRowAtIndexPath: IndexPath) -> CGFloat {
        return cells[heightForRowAtIndexPath.section][heightForRowAtIndexPath.row].tableView(tableView, heightForRowAt: heightForRowAtIndexPath)
    }

    // This is called when the row is tapped by the user.
    func tableView(_ tableView: UITableView, didSelectRowAt didSelectRowAtIndexPath: IndexPath) {
        switch cells[didSelectRowAtIndexPath.section][didSelectRowAtIndexPath.row] {

        case .navigation(_, _, let navigate):
            navigate()

        default:
            break
        }

        // This lets the row get a chance to to redraw and clear the selection if it wishes.
        tableView.reloadRows(at: [didSelectRowAtIndexPath], with: .automatic)
    }

}
