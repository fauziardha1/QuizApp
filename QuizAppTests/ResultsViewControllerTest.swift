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
    
    func test_viewDidLoad_withCorrectAnswer_configureCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1",answer: "A1", isCorrect: true)])
        _ = sut.view
        
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_configureCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1",answer: "A1", wrongAnswer: "wrong")])
        _ = sut.view
        
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
    }
    
    // MARK: Helpers
    private func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    private func makeDummyAnswer() -> PresentableAnswer {
        return makeAnswer(isCorrect: false)
    }
    
    private func makeAnswer(question: String = "", answer: String = "", wrongAnswer: String? = nil, isCorrect: Bool = false) -> PresentableAnswer {
        return PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
    }
}
