//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Fauzi Arda on 29/08/24.
//

import Foundation
import UIKit

struct PresentableAnswer {
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell { }
class WrongAnswerCell: UITableViewCell { }

class ResultsViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var summary: String = String()
    private var answers: [PresentableAnswer] = []
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerLabel.text = summary
        tableView.dataSource = self
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if answers[indexPath.row].isCorrect {
            return CorrectAnswerCell()
        }
        return WrongAnswerCell()
    }
}
