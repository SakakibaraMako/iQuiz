//
//  ViewController.swift
//  iQuiz
//
//  Created by stlp on 5/9/22.
//

import UIKit

class ViewController: UIViewController {

    var tableDataAndDelegate = TableDataAndDelegate()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableDataAndDelegate.vc = self
        tableView.dataSource = tableDataAndDelegate
        tableView.delegate = tableDataAndDelegate
    }

    @IBAction func btnSettingsTouched(_ sender: UIButton) {
        let alert = UIAlertController(title: "Settings", message: "Setting go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

