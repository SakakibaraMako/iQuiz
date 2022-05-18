//
//  QuizApp.swift
//  iQuiz
//
//  Created by stlp on 5/15/22.
//

import UIKit
import SystemConfiguration

class QuizApp {
    
    static let quizApp = QuizApp()
    let NO_INTERNET = 1
    let SUCCESS = 0
    let DOWNLOAD_FAILURE = 2
    let WRITE_FAILURE = 3
    let NIL_RESPONSE = 4
    let NUMBER_OF_CHOICES = 4
    
    private let sourceURL = URL(string: "http://tednewardsandbox.site44.com/questions.json")
    private let pathURL = URL(string: "file://\(NSHomeDirectory())/Documents/questions.json")
    
//    private let subjects : [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
//    private let subjectDescription : [String] = ["Mathematics is fun", "Marvel Super Heroes is fun", "Science is fun"]
    
    private var subjects : [String] = []
    private var subjectDescription : [String] = []
    
    
//    private let problemsDict : [String : [String]] =
//    ["Mathematics" : ["1 + 1 = ?", "2 + 2 = ?", "3 + 3 = ?"],
//     "Science" : ["What is the derivative of displacement?", "What is the derivative of velocity"],
//     "Marvel Super Heroes" : ["Which of the following is in Marvel Super Heroes?"]]
//
//    private let choicesDict : [String : [[String]]] =
//    ["Mathematics" : [["2", "4", "6", "8"],["2", "4", "6", "8"],["2", "4", "6", "8"]],
//     "Science" : [["Displacement", "Velocity", "Speed", "Acceleration"], ["Displacement", "Velocity", "Speed", "Acceleration"]],
//     "Marvel Super Heroes" : [["Naruto", "Ichigo", "Micky Mouse", "Captain America"]]]
//
//    private let answersDict : [String : [Int]] =
//    ["Mathematics" : [0, 1, 2],
//     "Science" : [1, 3],
//     "Marvel Super Heroes" : [3]]
    
    private var problemsDict : [String : [String]] = [:]
    private var choicesDict : [String : [[String]]] = [:]
    private var answersDict : [String : [Int]] = [:]
    
    private var currentIndex : Int = 0
    private var currentProblems : [String] = []
    private var currentChoices : [[String]] = [[]]
    private var currentAnswers : [Int] = []
//
//    let MathProlems : [String] = ["1 + 1 = ?", "2 + 2 = ?", "3 + 3 = ?"]
//    let MathChoices : [[String]] = [["2", "4", "6", "8"],["2", "4", "6", "8"],["2", "4", "6", "8"]]
//    let MathAnswers : [Int] = [0, 1, 2]
    
    private var correct = 0
    
    private let queue = DispatchQueue.global()
    
    func loadQuestions(_ viewController : UIViewController) {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: pathURL!.path) {
            download(sourceURL!, viewController)
        }
        if (fileManager.fileExists(atPath: pathURL!.path)) {
            do {
                let data = try Data(contentsOf: pathURL!, options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let subjects = json as? [Any] {
                    for subject in subjects {
                        if let dictionary = subject as? [String : Any] {
                            let title = dictionary["title"] as? String
                            let description = dictionary["desc"] as? String
                            if let questions = dictionary["questions"] as? [Any] {
                                var questionList : [String] = []
                                var choicesList : [[String]] = []
                                var answerIndexList : [Int] = []
                                for question in questions {
                                    if let questionDictionary = question as? [String : Any] {
                                        let answerIndex = questionDictionary["answer"] as? String
                                        let questionText = questionDictionary["text"] as? String
                                        let choices = questionDictionary["answers"] as? [String]
                                        answerIndexList.append(Int(answerIndex!)!)
                                        choicesList.append(choices!)
                                        questionList.append(questionText!)
                                    }
                                }
                                problemsDict[title!] = questionList
                                choicesDict[title!] = choicesList
                                answersDict[title!] = answerIndexList
                            }
                            self.subjects.append(title!)
                            subjectDescription.append(description!)
                        }
                    }
                }
            } catch {
                print("failed to read local JSON")
            }
        }
    }
    
    func download(_ url : URL, _ viewController : UIViewController) {
        if !hasInternet() {
            displayResult(NO_INTERNET, viewController)
        } else {
            print(NSHomeDirectory())
            let session = URLSession.shared.dataTask(with: url) { [self] data, response, error in
                if response != nil {
                    if (response! as! HTTPURLResponse).statusCode != 200 {
                        print("Something went wrong! \(error)")
                        displayResult(DOWNLOAD_FAILURE, viewController)
                    }
                    let httpResponse = response! as! HTTPURLResponse
                    print("session is not nil")
//                    print(data)
                    
                    let fileManager = FileManager.default
                    if fileManager.fileExists(atPath: pathURL!.path) {
                        print("enter file exist")
                        do {
                            try fileManager.removeItem(atPath: pathURL!.path)
                        } catch {
                            print("fail to remove old file")
                            displayResult(WRITE_FAILURE, viewController)
                        }
                    }
                    do {
                        print("enter write file")
                        try data!.write(to: pathURL!)
                        print("data wrote")
                        displayResult(SUCCESS, viewController)
//                        if fileManager.fileExists(atPath: pathURL!.path) {
//                            print("File stored")
//                            print(pathURL!)
//                            print(pathURL!.path)
//                        } else {
//                            print("why not exist")
//                        }
                    } catch {
                        print(error)
//                        flag = WRITE_FAILURE
                        displayResult(WRITE_FAILURE, viewController)
                    }
                } else {
                    displayResult(NIL_RESPONSE, viewController)
                }
            }
            session.resume()
        }
    }
    
    private func displayResult(_ result : Int, _ viewController : UIViewController) {
        var alert_title = ""
        var alert_message = ""
        switch result {
        case 1:
            alert_title = "FAILURE"
            alert_message = "No internet!"
        case 2:
            alert_title = "FAILURE"
            alert_message = "Fail to download!"
        case 3:
            alert_title = "Failure"
            alert_message = "Fail to store JSON file!"
        case 4:
            alert_title = "Failure"
            alert_title = "No response from the server!"
        default:
            alert_title = "SUCCESS"
            alert_message = "Task Finished!"
        }
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alert_title, message: alert_message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    private func hasInternet() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
                    
        }) else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
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
