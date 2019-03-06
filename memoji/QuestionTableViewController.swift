//
//  QuestionTableViewController.swift
//  memoji
//
//  Created by 옥재현 on 04/03/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class QuestionTableViewController: UITableViewController {
    
    var category = String()
    var categoryQuestions = [Question]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
        setupQuestionBank()

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
        return categoryQuestions.count
    }
    
    func setupQuestionBank() {
        if category == "KPOP" {
            let data = UserDefaults.standard.data(forKey: "kpop")
            let questions = NSKeyedUnarchiver.unarchiveObject(with: data!) as! [Question]
            categoryQuestions = questions
        }
        else if category == "드라마" {
            let data = UserDefaults.standard.data(forKey: "drama")
            let questions = NSKeyedUnarchiver.unarchiveObject(with: data!) as! [Question]
            categoryQuestions = questions
        }
        else if category == "영화" {
            let data = UserDefaults.standard.data(forKey: "movie")
            let questions = NSKeyedUnarchiver.unarchiveObject(with: data!) as! [Question]
            categoryQuestions = questions
        }
        else if category == "커스텀" {
            let data = UserDefaults.standard.data(forKey: "custom")
            if let questions = NSKeyedUnarchiver.unarchiveObject(with: data!) as? [Question] {
                categoryQuestions = questions
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)

        // Configure the cell...
        cell.backgroundColor = .clear
        cell.textLabel?.text = "#\(indexPath.row + 1) " + categoryQuestions[indexPath.row].emoji
        
        var answer = ""
        
        if categoryQuestions[indexPath.row].isSolved {
            for c in categoryQuestions[indexPath.row].answer {
                answer += c
            }
        }
        
        answer = answer.filter({$0 != "."})
        
        cell.detailTextLabel?.text = answer

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "GameView") as! GameViewController
        gameVC.questionNumber = indexPath.row
        gameVC.category = category
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
    func setupTableView() {
        self.tableView.rowHeight = 80.0
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background.png"))
        tableView.backgroundColor = .clear
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.clipsToBounds = true
        navigationController?.navigationItem.title = category
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
