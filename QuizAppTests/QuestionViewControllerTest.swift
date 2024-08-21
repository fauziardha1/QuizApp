//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by FauziArda on 13/08/24.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {
    
    func test_whenViewDidLoad_rendersQuestionHeaderText() {
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    func test_whenViewDidLoad_renderOptions() {
        let sut1 = makeSUT(options: [])
        let sut2 = makeSUT(options: ["A1"])
        let sut3 = makeSUT(options: ["A1", "A2"])
        XCTAssertEqual(sut1.tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(sut2.tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(sut3.tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_whenViewDidLoad_renderOneOptionText() {
        let sut = makeSUT(options: ["A1", "A2", "A3"])
        XCTAssertEqual(sut.tableView.title(at: 0), "A1")
        XCTAssertEqual(sut.tableView.title(at: 1), "A2")
        XCTAssertEqual(sut.tableView.title(at: 2), "A3")
    }
    
    func test_optionSelected_notifiesDelegate() {
        var receivedAnswer = String()
        let sut = makeSUT(options: ["A1"]) {
            receivedAnswer = $0
        }
        sut.tableView.select(at: 0)
        XCTAssertEqual(receivedAnswer, "A1")
    }
    
    
    // MARK: Helpers
    
    func makeSUT(question: String = String(), 
                 options: [String] = [],
                 _ selection: @escaping (String) -> Void = {_ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view
        return sut
    }
}

private extension UITableView {
    
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
    
    func select(at row: Int) {
        self.delegate?.tableView?(self, didSelectRowAt: IndexPath(row: row, section: 0))
    }
}
