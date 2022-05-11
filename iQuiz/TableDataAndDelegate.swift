//
//  TableDataAndDelegate.swift
//  iQuiz
//
//  Created by stlp on 5/9/22.
//

import UIKit

class TableDataAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var vc: ViewController?
    
    let topics : [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    let topicDescription : [String] = ["Mathematics is fun", "Marvel Super Heroes is fun", "Science is fun"]
    /*
     UITableViewDataSource methods
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("indexPath.item = \(indexPath.item)", "indexPath.row = \(indexPath.row)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
        cell.topicLabel.text = topics[indexPath.row]
        cell.descriptionLabel.text = topicDescription[indexPath.row]
        cell.topicImageView.image = UIImage(named: "image")
        return cell
    }
    
    /*
     UITableViewDelegate methods
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let alert = UIAlertController(title: "Selected!", message: "You selected \(topics[indexPath.row])!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        vc!.present(alert, animated: true, completion: nil)
    }


}
