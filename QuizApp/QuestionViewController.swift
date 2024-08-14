//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by FauziArda on 13/08/24.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController {
    private var question: String = ""
    private var options: [String] = []
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    convenience init(question: String, options: [String]) {
        self.init()
        self.question = question
        self.options = options
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        headerLabel.text = question
        self.tableView.dataSource = self
    }
}


extension QuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.options[indexPath.row]
        return cell
    }
    
    
}
