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
        
        var favoritesByOrderedCategory = [[String:[Question]]]()
        favoritesByCategory.sorted(by: {$0.key < $1.key}).forEach {
            favoritesByOrderedCategory.append([$0.key : $0.value])
        }
        let categoryKey = Array(favoritesByCategory.keys).sorted(by: {$0 < $1})[indexPath.section]
        let categoryValue = Array(favoritesByOrderedCategory[indexPath.section].values)
        var emojis = categoryValue[0].map({$0.emoji})
        
        var answers = [String]()
        var answer = ""
        
        if categoryKey == "kpop" {
            for i in kpopQuestionBank {
                for j in i.answer {
                    answer += j
                }
                answers.append(answer)
            }
        }
        
        if categoryKey == "drama" {
            for i in dramaQuestionBank {
                for j in i.answer {
                    answer += j
                }
                answers.append(answer)
            }
        }
        
        if categoryKey == "movie" {
            for i in movieQuestionBank {
                for j in i.answer {
                    answer += j
                }
                answers.append(answer)
            }
        }
        
        if categoryKey == "custom" {
            for i in customQuestionBank {
                for j in i.answer {
                    answer += j
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
            if let kpopFavorite = UserDefaults.standard.array(forKey: "kpopFavorite") as? [Int] {
                for i in kpopFavorite {
                    kpopQuestionBank.append(kpopQuestions[i-1])
                }
            }
            favoritesByCategory["kpop"] = kpopQuestionBank
        }
        if let dramaQuestions = NSKeyedUnarchiver.unarchiveObject(with: dramaData!) as? [Question] {
            if let dramaFavorite = UserDefaults.standard.array(forKey: "dramaFavorite") as? [Int] {
                for i in dramaFavorite {
                    dramaQuestionBank.append(dramaQuestions[i-1])
                }
            }
            favoritesByCategory["drama"] = dramaQuestionBank
        }
        if let movieQuestions = NSKeyedUnarchiver.unarchiveObject(with: movieData!) as? [Question] {
            if let movieFavorite = UserDefaults.standard.array(forKey: "movieFavorite") as? [Int] {
                for i in movieFavorite {
                    movieQuestionBank.append(movieQuestions[i-1])
                }
            }
            favoritesByCategory["movie"] = movieQuestionBank
        }
        if let customQuestions = NSKeyedUnarchiver.unarchiveObject(with: customData!) as? [Question] {
            if let customFavorite = UserDefaults.standard.array(forKey: "customFavorite") as? [Int] {
                for i in customFavorite {
                    customQuestionBank.append(customQuestions[i-1])
                }
            }
            favoritesByCategory["custom"] = customQuestionBank
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
