//
//  ResultsViewController.swift
//  QuizAppTests
//
//  Created by Fauzi Arda on 29/08/24.
//

import Foundation
import XCTest
@testable import QuizApp

class ResultsViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renderSummary() {
        XCTAssertEqual(makeSUT().headerLabel.text, "")
    }
    
    func test_viewDidload_withoutAnswer_doneNotRenderAnswers() {
        XCTAssertEqual(makeSUT().tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidload_withOneAnswer_renderOneAnswers() {
        let sut = makeSUT(answers: [makeDummyAnswer()])
        _ = sut.view
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_renderCorrecAnswertCell() {
        let sut = makeSUT(answers: [PresentableAnswer(isCorrect: true)])
        _ = sut.view
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
    }
    
    func test_viewDidLoad_withWrongAnswer_renderWrongAnswertCell() {
        let sut = makeSUT(answers: [PresentableAnswer(isCorrect: false)])
        _ = sut.view
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
    }
    
    // MARK: Helpers
    private func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    func makeDummyAnswer() -> PresentableAnswer {
        return PresentableAnswer(isCorrect: false)
    }
}
