//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by stlp on 5/16/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let app = QuizApp.quizApp

    @IBOutlet weak var URLTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        UserDefaults.standard.synchronize()
        let url = UserDefaults.standard.string(forKey: "source_url")! as String
        URLTextField.text = url
    }
    
    @IBAction func btnCheckClicked(_ sender: Any) {
        app.download(URL(string: URLTextField.text!)!, self)
    }
    
    @IBAction func btnOkClicked(_ sender: Any) {
        UserDefaults.standard.set(URLTextField.text, forKey: "source_url")
        self.dismiss(animated: true)
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
