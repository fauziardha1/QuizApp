//
//  TableViewHelpers.swift
//  QuizAppTests
//
//  Created by Fauzi Arda on 12/09/24.
//

import Foundation
import UIKit
extension UITableView {
    
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
    
    func select(at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        self.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        self.delegate?.tableView?(self, didSelectRowAt: indexPath)
    }
    
    func deselect(at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        self.deselectRow(at: indexPath, animated: false)
        self.delegate?.tableView?(self, didDeselectRowAt: indexPath)
    }
}
