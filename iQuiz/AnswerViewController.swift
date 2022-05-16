//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by stlp on 5/15/22.
//

import UIKit

class AnswerViewController: UIViewController {

    private let app = QuizApp.quizApp

    var choiceIndex = -1
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionLabel.text = app.getProblems()[app.getIndex()]
        
        let correctIndex = app.getAnswers()[app.getIndex()]
        answerLabel.text = "Correct Answer: \(app.getChoices()[app.getIndex()][correctIndex])"
        if correctIndex == choiceIndex {
            resultLabel.text = "CORRECT!"
            app.correctAnswered()
        } else {
            resultLabel.text = "WRONG!"
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
//        self.dismiss(animated: true)
//        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        app.backToMain(self)
    }
    
    @IBAction func next(_ sender: Any) {
        if (app.getIndex() < app.getProblems().count - 1) {
            // next question
            performSegue(withIdentifier: "answerToNextQuestion", sender: self)
        } else {
            performSegue(withIdentifier: "answerToFinish", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Optional("answerToNextQuestion"):
            app.nextQuestion()
        case Optional("answerToFinish"):
            print("answer To finish")
        default: print("Invalid Segue")
        }
    }

}
