//
//  FavoriteTableViewController.swift
//  memoji
//
//  Created by CAU on 19/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    var favoriteList = [Question]()
    var favoritesByCategory = [String:[Question]]()
    var kpopQuestionBank = [Question]()
    var dramaQuestionBank = [Question]()
    var movieQuestionBank = [Question]()
    var customQuestionBank = [Question]()
    var favoriteQuestionEmoji = [String]()
    var favoriteQuestionAnswer = [String]()
    @IBOutlet weak var okButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupQuestionBank()
        setupTableView()

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
        var categoryKey = Array(favoritesByCategory.keys).sorted(by: {$0 < $1})[section]
        if categoryKey == "kpop" {
            categoryKey = "KPOP"
        } else if categoryKey == "drama" {
            categoryKey = "드라마"
        } else if categoryKey == "movie" {
            categoryKey = "영화"
        } else if categoryKey == "custom" {
            categoryKey = "커스텀"
        }
        
        return categoryKey
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        
        cell.backgroundColor = .clear
        
        let categoryKey = Array(favoritesByCategory.keys).sorted(by: {$0 < $1})[indexPath.section]
        let categoryValue = Array(favoritesByCategory.values)[indexPath.section]
        let emojis = categoryValue.map({$0.emoji})
        
        var answers = [String]()
        var answer = ""
        
        if categoryKey == "kpop" {
            if let kpopFavorite = UserDefaults.standard.array(forKey: "kpopFavorite") as? [Int] {
                for i in kpopFavorite {
                    favoriteQuestionEmoji.append(kpopQuestionBank[i-1].emoji)
                    
                    if let kpopSolved = UserDefaults.standard.array(forKey: "kpopSolved") as? [Int] {
                        if kpopSolved.contains(i) {
                            for j in kpopQuestionBank[i-1].answer {
                                answer += j
                            }
                        }
                    }
                    answers.append(answer)
                }
            }
        } else if categoryKey == "drama" {
            if let dramaFavorite = UserDefaults.standard.array(forKey: "dramaFavorite") as? [Int] {
                for i in dramaFavorite {
                    favoriteQuestionEmoji.append(dramaQuestionBank[i-1].emoji)
                    
                    if let dramaSolved = UserDefaults.standard.array(forKey: "dramaSolved") as? [Int] {
                        if dramaSolved.contains(i) {
                            for j in dramaQuestionBank[i-1].answer {
                                answer += j
                            }
                        }
                    }
                    answers.append(answer)
                }
            }
        } else if categoryKey == "movie" {
            if let movieFavorite = UserDefaults.standard.array(forKey: "movieFavorite") as? [Int] {
                for i in movieFavorite {
                    favoriteQuestionEmoji.append(movieQuestionBank[i-1].emoji)
                    
                    if let movieSolved = UserDefaults.standard.array(forKey: "movieSolved") as? [Int] {
                        if movieSolved.contains(i) {
                            for j in movieQuestionBank[i-1].answer {
                                answer += j
                            }
                        }
                    }
                    answers.append(answer)
                }
            }
        } else if categoryKey == "custom" {
            if let customFavorite = UserDefaults.standard.array(forKey: "customFavorite") as? [Int] {
                for i in customFavorite {
                    favoriteQuestionEmoji.append(customQuestionBank[i-1].emoji)
                    
                    if let customSolved = UserDefaults.standard.array(forKey: "customSolved") as? [Int] {
                        if customSolved.contains(i) {
                            for j in customQuestionBank[i-1].answer {
                                answer += j
                            }
                        }
                    }
                }
                answers.append(answer)
            }
        }
        
        cell.textLabel?.text = emojis[indexPath.row]
        cell.detailTextLabel?.text = answers[indexPath.row]

        return cell
    }
    
    func setupQuestionBank() {
        let kpopData = UserDefaults.standard.data(forKey: "kpop")
        let dramaData = UserDefaults.standard.data(forKey: "drama")
        let movieData = UserDefaults.standard.data(forKey: "movie")
        let customData = UserDefaults.standard.data(forKey: "custom")
        
        if let kpopQuestions = NSKeyedUnarchiver.unarchiveObject(with: kpopData!) as? [Question] {
            kpopQuestionBank += kpopQuestions
            favoritesByCategory["kpop"] = kpopQuestions
        }
        if let dramaQuestions = NSKeyedUnarchiver.unarchiveObject(with: dramaData!) as? [Question] {
            dramaQuestionBank += dramaQuestions
            favoritesByCategory["drama"] = dramaQuestions
        }
        if let movieQuestions = NSKeyedUnarchiver.unarchiveObject(with: movieData!) as? [Question] {
            movieQuestionBank += movieQuestions
            favoritesByCategory["movie"] = movieQuestions
        }
        if let customQuestions = NSKeyedUnarchiver.unarchiveObject(with: customData!) as? [Question] {
            customQuestionBank += customQuestions
            favoritesByCategory["custom"] = customQuestions
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
