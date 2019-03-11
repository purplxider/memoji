//
//  FavoriteTableViewController.swift
//  memoji
//
//  Created by CAU on 19/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    var favoritesByCategory = [String:[Question]]()
    var kpopQuestionBank = [Question]()
    var dramaQuestionBank = [Question]()
    var movieQuestionBank = [Question]()
    var customQuestionBank = [Question]()
    @IBOutlet weak var okButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        setupQuestionBank()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return favoritesByCategory.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let categoryValues = Array(favoritesByCategory.values)[section]
        return categoryValues.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let categoryKey = Array(favoritesByCategory.keys).sorted(by: {$0 < $1})[section]
        var title = ""
        
        if categoryKey == "1kpop" {
            title = "KPOP"
        } else if categoryKey == "2drama" {
            title = "드라마"
        } else if categoryKey == "3movie" {
            title = "영화"
        } else if categoryKey == "4custom" {
            title = "커스텀"
        }
        
        return title
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.tintColor = .clear
            headerView.backgroundColor = .clear
            headerView.tintColor = .clear
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        var question = Question(emoji: "", length: 0, answer: [])
        
        cell.backgroundColor = .clear
        
        let categoryKey = Array(favoritesByCategory.keys).sorted(by: {$0 < $1})[indexPath.section]
        if let categoryValue = favoritesByCategory[categoryKey] {
            let emojis = categoryValue.map({$0.emoji})
            if !emojis.isEmpty {
                question = categoryValue[indexPath.row]
                cell.textLabel?.text = emojis[indexPath.row]
            }
        }
        
        var answers = setupAnswer(categoryKey: categoryKey)

        if question.isSolved {
            cell.detailTextLabel?.text = answers[indexPath.row]
        } else {
            cell.detailTextLabel?.text = ""
        }

        return cell
    }
    
    func setupAnswer(categoryKey:String) -> [String] {
        var answers = [String]()
        var answer = ""
        
        if categoryKey == "1kpop" {
            for i in kpopQuestionBank {
                if i.isSolved {
                    for j in i.answer {
                        answer += j
                    }
                    answers.append(answer)
                }
            }
        }
        
        if categoryKey == "2drama" {
            for i in dramaQuestionBank {
                if i.isSolved {
                    for j in i.answer {
                        answer += j
                    }
                    answers.append(answer)
                }
            }
        }
        
        if categoryKey == "3movie" {
            for i in movieQuestionBank {
                if i.isSolved {
                    for j in i.answer {
                        answer += j
                    }
                    answers.append(answer)
                }
            }
        }
        
        if categoryKey == "4custom" {
            for i in customQuestionBank {
                if i.isSolved {
                    for j in i.answer {
                        answer += j
                    }
                    answers.append(answer)
                }
            }
        }

        if answers.count == 0 {answers.append("")}
        return answers
    }
    
    func setupQuestionBank() {
        let kpopData = UserDefaults.standard.data(forKey: "kpop")
        let dramaData = UserDefaults.standard.data(forKey: "drama")
        let movieData = UserDefaults.standard.data(forKey: "movie")
        
        if let kpopQuestions = NSKeyedUnarchiver.unarchiveObject(with: kpopData!) as? [Question] {
            kpopQuestionBank = kpopQuestions
            kpopQuestionBank = kpopQuestionBank.filter({$0.isFavorite})
            if !kpopQuestionBank.isEmpty {
                favoritesByCategory["1kpop"] = kpopQuestionBank
            }
        }
        if let dramaQuestions = NSKeyedUnarchiver.unarchiveObject(with: dramaData!) as? [Question] {
            dramaQuestionBank = dramaQuestions
            dramaQuestionBank = dramaQuestionBank.filter({$0.isFavorite})
            if !dramaQuestionBank.isEmpty {
                favoritesByCategory["2drama"] = dramaQuestionBank
            }
        }
        if let movieQuestions = NSKeyedUnarchiver.unarchiveObject(with: movieData!) as? [Question] {
            movieQuestionBank = movieQuestions
            movieQuestionBank = movieQuestionBank.filter({$0.isFavorite})
            if !movieQuestionBank.isEmpty {
                favoritesByCategory["3movie"] = movieQuestionBank
            }
        }
        
        if let customData = UserDefaults.standard.data(forKey: "custom") {
            if let customQuestions = NSKeyedUnarchiver.unarchiveObject(with: customData) as? [Question] {
                customQuestionBank = customQuestions
                customQuestionBank = customQuestionBank.filter({$0.isFavorite})
                if !customQuestionBank.isEmpty {
                    favoritesByCategory["4custom"] = customQuestionBank
                }
            }
        }
    }
    
    func setupTableView() {
        self.tableView.rowHeight = 80.0
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background.png"))
        tableView.backgroundColor = .clear
    }
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.clipsToBounds = true
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
