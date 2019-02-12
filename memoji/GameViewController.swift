//
//  GameViewController.swift
//  memoji
//
//  Created by CAU on 07/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var gameToolBar: UIToolbar!
    @IBOutlet weak var memoImage: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    
    
    var answerPool = ["다", "단", "만", "싱", "가", "계", "맘", "난", "시", "말", "낙", "세", "셀", "날"] // 수정
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.frame = UIScreen.main.bounds
        answerView.backgroundColor = UIColor(red: 208/255.0, green: 211/255.0, blue: 217/255.0, alpha: 1.0)
        setupToolBar()
        setupAnswerPool()
        setupAnswerBlock()
        setupQuestion()
        
        navigationItem.title = "#1" // 수정
        
        backgroundImage.image = UIImage(named: "background.png")
        memoImage.image = UIImage(named: "memo.png")

        // Do any additional setup after loading the view.
    }
    
    func setupToolBar() {
        let clear = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: nil) // 수정
        clear.tintColor = UIColor.darkGray
        let hint = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil) // 수정
        hint.tintColor = UIColor.darkGray
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil) // 수정
        share.tintColor = UIColor.darkGray
        let favorite = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil) // 수정
        favorite.tintColor = UIColor.darkGray
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        var items = [UIBarButtonItem]()
        items.append(clear)
        items.append(space)
        items.append(hint)
        items.append(space)
        items.append(favorite)
        items.append(space)
        items.append(share)
        gameToolBar.setItems(items, animated: true)
    }
    
    func setupAnswerPool() {
        var button = UIButton()
        var x = 21
        var y = 51
        var count = 0
        
        for _ in 0...1 {
            for _ in 0...6 {
                button = UIButton(frame: CGRect(x: x, y: y, width: 32, height: 42))
                button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitle(answerPool[count], for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.tag = count
                button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
                button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                button.layer.shadowOpacity = 1.0
                button.layer.shadowRadius = 0.0
                button.layer.masksToBounds = false
                button.layer.cornerRadius = 4.0
                self.answerView.addSubview(button)
                x = x + 50
                count = count + 1
            }
            x = 21
            y = y + 72
        }
    }
    
    func setupAnswerBlock() {
        var button = UIButton()
        var x = 16
        let y = 323
        var count = 0
        
        for _ in 0...5 {
            button = UIButton(frame: CGRect(x: x, y: y, width: 44, height: 44))
            button.backgroundColor = UIColor(red: 196/255.0, green: 196/255.0, blue: 196/255.0, alpha: 1.0)
            button.tag = count
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0.7
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 4.0
            self.view.addSubview(button)
            x = x + 60
            count = count + 1
        }
    }
    
    func setupQuestion() {
        questionLabel.text = "🔁🤝🌏"
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
