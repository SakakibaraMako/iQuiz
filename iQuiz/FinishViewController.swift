//
//  FinishViewController.swift
//  iQuiz
//
//  Created by stlp on 5/15/22.
//

import UIKit

class FinishViewController: UIViewController {
    
    private let app = QuizApp.quizApp

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let correct = app.getCorrect()
        let total = app.getProblems().count
        let ratio = Double(correct) / Double(total)
        
        switch ratio {
        case 1.0: resultLabel.text = "Perfect!"
        case let r where r > 0.75: resultLabel.text = "Almost!"
        case let r where r > 0.25: resultLabel.text = "Normal"
        case let r where r < 0.25: resultLabel.text = "Poor"
        default: resultLabel.text = "What's Your Score?"
        }
        
        scoreLabel.text = "\(correct) of \(total) correct!"
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        app.backToMain(self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
