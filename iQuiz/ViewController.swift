//
//  ViewController.swift
//  iQuiz
//
//  Created by stlp on 5/9/22.
//

import UIKit

class ViewController: UIViewController {

    private var tableDataAndDelegate = TableDataAndDelegate()
    private let app = QuizApp.quizApp
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        app.loadQuestions(self)
        tableDataAndDelegate.vc = self
        tableView.dataSource = tableDataAndDelegate
        tableView.delegate = tableDataAndDelegate
    }

    @IBAction func btnSettingsTouched(_ sender: UIButton) {
//        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:])
        print("enter settings")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier
        {
        case Optional("mainToQuestion"):
            let questionVC = segue.destination as! QuestionViewController
            let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! TopicCell
            questionVC.subject = cell.topicLabel.text!
        case Optional("mainToSettings"):
            print("to Settings")
        default:
            print("invalid segue")
        }
    }
}

