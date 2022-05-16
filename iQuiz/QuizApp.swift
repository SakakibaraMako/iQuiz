//
//  QuizApp.swift
//  iQuiz
//
//  Created by stlp on 5/15/22.
//

import UIKit

class QuizApp {
    
    static let quizApp = QuizApp()
    let NUMBER_OF_CHOICES = 4
    
    private let subjects : [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    private let subjectDescription : [String] = ["Mathematics is fun", "Marvel Super Heroes is fun", "Science is fun"]
    
    private let problemsDict : [String : [String]] =
    ["Mathematics" : ["1 + 1 = ?", "2 + 2 = ?", "3 + 3 = ?"],
     "Science" : ["What is the derivative of displacement?", "What is the derivative of velocity"],
     "Marvel Super Heroes" : ["Which of the following is in Marvel Super Heroes?"]]
    
    private let choicesDict : [String : [[String]]] =
    ["Mathematics" : [["2", "4", "6", "8"],["2", "4", "6", "8"],["2", "4", "6", "8"]],
     "Science" : [["Displacement", "Velocity", "Speed", "Acceleration"], ["Displacement", "Velocity", "Speed", "Acceleration"]],
     "Marvel Super Heroes" : [["Naruto", "Ichigo", "Micky Mouse", "Captain America"]]]
    
    private let answersDict : [String : [Int]] =
    ["Mathematics" : [0, 1, 2],
     "Science" : [1, 3],
     "Marvel Super Heroes" : [3]]
    
    private var currentIndex : Int = 0
    private var currentProblems : [String] = []
    private var currentChoices : [[String]] = [[]]
    private var currentAnswers : [Int] = []
//
//    let MathProlems : [String] = ["1 + 1 = ?", "2 + 2 = ?", "3 + 3 = ?"]
//    let MathChoices : [[String]] = [["2", "4", "6", "8"],["2", "4", "6", "8"],["2", "4", "6", "8"]]
//    let MathAnswers : [Int] = [0, 1, 2]
    
    private var correct = 0
    
    func getSubjects() -> [String] {
        return subjects
    }
    
    func getSubjectDescription() -> [String] {
        return subjectDescription
    }
    
    func getIndex() -> Int {
        return currentIndex
    }
    
    func setData(_ subject : String) {
        currentIndex = 0
        correct = 0
        setProblems(subject)
        setChoices(subject)
        setAnswers(subject)
    }
    
    private func setProblems(_ subject : String) {
        currentProblems = problemsDict[subject]!
    }
    
    private func setChoices(_ subject : String) {
        currentChoices =  choicesDict[subject]!
    }
    
    private func setAnswers(_ subject : String) {
        currentAnswers = answersDict[subject]!
    }
    
    func getProblems() -> [String] {
        return currentProblems
    }
    
    func getChoices() -> [[String]] {
        return currentChoices
    }
    
    func getAnswers() -> [Int] {
        return currentAnswers
    }
    
    func correctAnswered() {
        correct += 1
    }
    
    func backToMain(_ viewController : UIViewController) {
        viewController.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func nextQuestion() {
        currentIndex += 1
    }
    
    func getCorrect() -> Int {
        return correct
    }
}
