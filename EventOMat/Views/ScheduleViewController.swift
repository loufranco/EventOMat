//
//  ScheduleViewController.swift
//  EventOMat
//
//  Created by Louis Franco on 2/20/17.
//  Copyright © 2017 Lou Franco. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var dayPicker: UISegmentedControl!
    @IBOutlet var tableView: UITableView!

    // These are used by the table data source to configure cells.
    var cells: CellViewable!

    let schedule = Schedule.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        (UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])).textAlignment = .center

        self.title = "Schedule"

        setCellsFromFilter()

        // This is how you get table view cells where their constraints determine their height.
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 88

        self.searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    func setCells(fromScheduleItems items: [[ScheduleItem]]) {
        let cellArray = items.reduce([[CellType]]()) { (cells: [[CellType]], items: [ScheduleItem]) -> [[CellType]] in
            let sectionCells = items.map({ item -> CellType in
                return .schedule(item: item)
            })
            var newCells = cells
            newCells.append(sectionCells)
            return newCells
        }
        cells = CellViewable(viewController: self, cells: cellArray, sectionHeaderForCells: { (cells: [CellType]) -> String in
            guard cells.count > 0, case let .schedule(item) = cells[0] else {
                return ""
            }
            return "\(item.startTime):00"
        })

        self.tableView.dataSource = cells
        self.tableView.delegate = cells
        self.tableView.reloadData()
    }

    func setCellsFromFilter() {
        let items = schedule.itemsGroupedByTimeFiltered(byDay: ["sat", "sun"][dayPicker.selectedSegmentIndex], searchTerm: self.searchBar.text)
        setCells(fromScheduleItems: items)
    }

    @IBAction func dayChanged(sender: UISegmentedControl) {
        setCellsFromFilter()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        setCellsFromFilter()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        setCellsFromFilter()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let itemVC = segue.destination as? ScheduleItemViewController,
        let indexPath = self.tableView.indexPathForSelectedRow,
        case let CellType.schedule(item) = cells.cells[indexPath.section][indexPath.row]
            else {
            return
        }

        itemVC.item = item
    }
}
