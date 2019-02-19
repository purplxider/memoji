//
//  FavoriteTableViewController.swift
//  memoji
//
//  Created by CAU on 19/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    var favoriteList = UserDefaults.standard.array(forKey: "favorite") as! [Int]
    var questionBank = [Question]()
    var favoriteQuestionBank = [Int:Question]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoriteList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        
        for i in favoriteList {
            favoriteQuestionBank[i] = questionBank[i]
        }
        
        let favoriteQuestions = Array(favoriteQuestionBank.values)
        var answer = String()
        
        for answerKeys in favoriteQuestions[indexPath.row].answer {
            answer.append(answerKeys)
        }
        
        cell.textLabel?.text = "\(favoriteQuestions[indexPath.row].emoji)"
        cell.detailTextLabel?.text = answer

        return cell
    }
    
    func setupTableView() {
        self.tableView.rowHeight = 80.0
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background.png"))
        tableView.backgroundColor = .clear
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
