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
    var answerLength = 6 // 수정
    var questionNumber = 1 // 수정
    var hiddenButtonTag = [Int:Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupToolBar()
        setupAnswerPool()
        setupAnswerBlock()
        setupQuestion()
    }
    
    func setupView() {
        backgroundImage.frame = UIScreen.main.bounds
        answerView.backgroundColor = UIColor(red: 208/255.0, green: 211/255.0, blue: 217/255.0, alpha: 1.0)
        backgroundImage.image = UIImage(named: "background.png")
        memoImage.image = UIImage(named: "memo.png")
        navigationItem.title = "#\(questionNumber)" // 수정
    }
    
    func nextQuestion() { // 수정
        questionNumber = questionNumber + 1
    }
    
    func setupToolBar() {
        let clear = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(removeAll)) // 수정
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
    
    func setupAnswerBlock() { // 수정
        var button = UIButton()
        var x = 16
        let y = 323
        var count = 0
        
        for _ in 1...answerLength {
            button = UIButton(frame: CGRect(x: x, y: y, width: 44, height: 44))
            button.backgroundColor = UIColor(red: 196/255.0, green: 196/255.0, blue: 196/255.0, alpha: 1.0)
            button.tag = count + 100
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0.7
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 4.0
            button.showsTouchWhenHighlighted = true
            button.addTarget(self, action: #selector(deselectAnswer(_:)), for: .touchUpInside)
            self.view.addSubview(button)
            x = x + 60
            count = count + 1
        }
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
                button.tag = count + 200
                button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
                button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                button.layer.shadowOpacity = 1.0
                button.layer.shadowRadius = 0.0
                button.layer.masksToBounds = false
                button.layer.cornerRadius = 4.0
                button.showsTouchWhenHighlighted = true
                button.addTarget(self, action: #selector(selectAnswer(_:)), for: .touchUpInside)
                self.answerView.addSubview(button)
                x = x + 50
                count = count + 1
            }
            x = 21
            y = y + 72
        }
    }
    
    func setupQuestion() {
        questionLabel.text = "🔁🤝🌏"
    }
    
    @objc func removeAll() {
        for i in 100...(100+answerLength) {
            if let answerButton = self.view.viewWithTag(i) as? UIButton {
                if let poolButtonKey = hiddenButtonTag[answerButton.tag] {
                    if let poolButton = self.view.viewWithTag(poolButtonKey) as? UIButton {
                        if answerButton.titleLabel?.text != nil || answerButton.titleLabel?.text != " " {
                            answerButton.setTitle(" ", for: .normal)
                            poolButton.isHidden = false
                            hiddenButtonTag.removeValue(forKey: answerButton.tag)
                            print(hiddenButtonTag)
                        }
                        continue
                    }
                }
            }
        }
    }
    
    @objc func selectAnswer(_ poolButton: UIButton) {
        for i in 100...(100+answerLength) {
            if let answerButton = self.view.viewWithTag(i) as? UIButton {
                if answerButton.titleLabel?.text == nil || answerButton.titleLabel?.text == " " {
                    answerButton.setTitle(poolButton.titleLabel?.text, for: .normal)
                    poolButton.isHidden = true
                    hiddenButtonTag[answerButton.tag] = poolButton.tag
                    break
                }
                continue
            }
        }
    }
    
    @objc func deselectAnswer(_ answerButton: UIButton) {
        let hiddenButtonKeys = Array(hiddenButtonTag.keys)
        if hiddenButtonKeys.contains(answerButton.tag) {
            let key = answerButton.tag
            if let poolButtonTag = hiddenButtonTag[key] {
                if let poolButton = self.view.viewWithTag(poolButtonTag) as? UIButton {
                    answerButton.setTitle(" ", for: .normal)
                    poolButton.isHidden = false
                    hiddenButtonTag.removeValue(forKey: key)
                }
            }
        }
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
