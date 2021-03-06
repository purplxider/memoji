//
//  CategoryTableViewController.swift
//  memoji
//
//  Created by CAU on 07/02/2019.
//  Copyright © 2019 purplxider. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    let categories = ["KPOP", "드라마", "영화", "커스텀"] // 수정
    var money = UserDefaults.standard.integer(forKey: "money")
    let moneyButton = UIButton(type: .system)
    var category: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
        setupMoneyButton()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupToolbar()
        
        money = UserDefaults.standard.integer(forKey: "money")
        moneyButton.setTitle(" \(money)", for: .normal)
        moneyButton.sizeToFit()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        navigationController?.setToolbarHidden(true, animated: false)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        // Configure the cell...
        
        let categoryName = categories[indexPath.row]
        cell.textLabel?.text = categoryName
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func setupTableView() {
        self.tableView.rowHeight = 80.0
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background.png"))
        tableView.backgroundColor = .clear
    }
    
    func setupToolbar() {
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        navigationController?.toolbar.clipsToBounds = true
        navigationController?.toolbar.tintColor = UIColor(red: 228/255.0, green: 175/255.0, blue: 10/255.0, alpha: 1.0)
        let plus = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addQuestion))
        let favorite = UIBarButtonItem(image: UIImage(named: "filledHeart.png"), style: .plain, target: self, action: #selector(seeFavorites)) // 수정
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        var items = [UIBarButtonItem]()
        items.append(plus)
        items.append(space)
        items.append(favorite)
        self.toolbarItems = items
    }
    
    func setupMoneyButton() {
        moneyButton.setImage(UIImage(named: "user.png"), for: .normal)
        moneyButton.setTitle(" \(money)", for: .normal)
        moneyButton.titleLabel?.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
        moneyButton.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moneyButton)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.clipsToBounds = true
    }
    
    @objc func addQuestion() {
        let storyboard = UIStoryboard(name: "CustomQuestion", bundle: nil)
        let addVC = storyboard.instantiateViewController(withIdentifier: "CustomNavigation") as! UINavigationController
        
        present(addVC, animated: true, completion: nil)
    }
    
    @objc func seeFavorites() {
        let storyboard = UIStoryboard(name: "Favorite", bundle: nil)
        let favoriteVC = storyboard.instantiateViewController(withIdentifier: "FavoriteNavigation") as! UINavigationController
        
        present(favoriteVC, animated: true, completion: nil)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "selectCategory" {
            
            if let cell = self.tableView.cellForRow(at: self.tableView.indexPathForSelectedRow!) as? UITableViewCell {
                category = (cell.textLabel?.text)!
            }
            
            let questionVC = segue.destination as! QuestionTableViewController
            questionVC.category = category
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let cell = self.tableView.cellForRow(at: self.tableView.indexPathForSelectedRow!) as? UITableViewCell {
            category = (cell.textLabel?.text)!
        }
        
        
        if category != "커스텀" {
            return true
        } else if let data = UserDefaults.standard.data(forKey: "custom") {
            return true
        } else {
            let alert = UIAlertController(title: "커스텀 문제가 없습니다", message: nil, preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(dismiss)
            
            self.present(alert, animated: true)
            
            return false
        }
    }
    

}
