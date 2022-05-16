//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by stlp on 5/15/22.
//

import UIKit

class QuestionViewController: UIViewController {
    
    private let app = QuizApp.quizApp
    
    var subject = ""
    private var tableDataAndDelegate = TableDataAndDelegate()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var questoinLabel: UILabel!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questoinLabel.text = app.getProblems()[app.getIndex()]
        tableDataAndDelegate.vc = self
        tableView.dataSource = tableDataAndDelegate
        tableView.delegate = tableDataAndDelegate
    }
    
    @IBAction func back(_ sender: UIButton) {
//        self.dismiss(animated: true)
        app.backToMain(self)
    }
    
    @IBAction func submit(_ sender: UIButton) {
        self.performSegue(withIdentifier: "questionToAnswer", sender: self)
    }
    
    // MARK: - Navigation

//  In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier
        {
        case Optional("questionToAnswer"):
            let answerVC = segue.destination as! AnswerViewController
//            let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!)
//            questionVC.subject = cell.topicLabel.text!
            answerVC.choiceIndex = tableView.indexPathForSelectedRow!.row
        default:
            print("invalid segue")
        }
    }

}
