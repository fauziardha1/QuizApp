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
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1"]) {
            receivedAnswer = $0
        }
        sut.tableView.select(at: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
    }
    
    func test_optionSelected_withSingleSelection_notifiesDelegateWithLastSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1","A2"]) {
            receivedAnswer = $0
        }
        sut.tableView.select(at: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(at: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionSelected_withSingleSelection_DoesNotnotifiesDelegateWithEmptySelections() {
        var callbackCount = 0
        let sut = makeSUT(options: ["A1","A2"]) { _ in
            callbackCount += 1
        }
        sut.tableView.select(at: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(at: 10)
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_optionSelected_withMultipleSelctionEnabled_notifiesDelegateSelections() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1","A2"]) {
            receivedAnswer = $0
        }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(at: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(at: 1)
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
    }
    
    func test_optionDeSelected_withMultipleSelctionEnabled_notifiesDelegate() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1","A2"]) {
            receivedAnswer = $0
        }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(at: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.deselect(at: 0)
        XCTAssertEqual(receivedAnswer, []) 
    }
    
    
    // MARK: Helpers
    
    func makeSUT(question: String = String(), 
                 options: [String] = [],
                 _ selection: @escaping ([String]) -> Void = {_ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view
        return sut
    }
}

