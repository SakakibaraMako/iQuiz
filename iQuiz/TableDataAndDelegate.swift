//
//  TableDataAndDelegate.swift
//  iQuiz
//
//  Created by stlp on 5/9/22.
//

import UIKit

class TableDataAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var vc: UIViewController?
    private let app = QuizApp.quizApp

    /*
     UITableViewDataSource methods
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 0: return app.getSubjects().count
        case 1: return app.NUMBER_OF_CHOICES
        default: return 0
        }
    }

    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("indexPath.item = \(indexPath.item)", "indexPath.row = \(indexPath.row)")
        if tableView.tag == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
            cell.topicLabel.text = app.getSubjects()[indexPath.row]
            cell.descriptionLabel.text = app.getSubjectDescription()[indexPath.row]
            cell.topicImageView.image = UIImage(named: "image")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath)
            cell.textLabel!.text = app.getChoices()[app.getIndex()][indexPath.row]
            cell.textLabel!.numberOfLines = 0
            return cell
        }
    }
    
    /*
     UITableViewDelegate methods
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        let alert = UIAlertController(title: "Selected!", message: "You selected \(topics[indexPath.row])!", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
//        vc!.present(alert, animated: true, completion: nil)
        switch tableView.tag {
        case 0:
            app.setData(app.getSubjects()[indexPath.row])
            vc?.performSegue(withIdentifier: "mainToQuestion", sender: vc)
        case 1:
            let questionView = vc as! QuestionViewController
            questionView.btnSubmit.isEnabled = true
        default: print("Invalid tableView tag")
        }
    }


}
