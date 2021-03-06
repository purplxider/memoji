//
//  GameViewController.swift
//  memoji
//
//  Created by CAU on 07/02/2019.
//  Copyright © 2019 purplxider. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var gameToolBar: UIToolbar!
    @IBOutlet weak var memoImage: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    
    // 기본적으로 필요한 변수
    var category: String!
    var categoryQuestions = [Question]()
    var question = Question(emoji: "🔁🤝🌏", length: 6, answer: ["다", "시", "만", "난", "세", "계"])
    var money = UserDefaults.standard.integer(forKey: "money")
    var questionNumber = Int()
    let moneyButton = UIButton(type: .system)
    var isFavorite = false
    var isSolved = false
    
    // 문제가 바뀔 때 업데이트 해줘야하는 값
    var emoji = String()
    var answerPool = [String]()
    var answer = [String]()
    var answerLength = Int()
    var userAnswer = [String]()
    var hiddenButtonTag = [Int:Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoImage.isHidden = true
        
        setupQuestionBank()
        setupCurrentQuestion()
        
        // 화면 구성 셋업
        setupView()
        setupToolBar()
        if isSolved == false {
            setupAnswerPool()
        }
        setupAnswerBlock()
        setupMoneyButton()
    }
    
    // 각종 함수들입니다
    
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
    
    func setupCurrentQuestion() {
        question = categoryQuestions[questionNumber]
        emoji = question.emoji
        answer = question.answer
        answerLength = question.length
        isFavorite = question.isFavorite
        isSolved = question.isSolved
        
        for _ in 1...answerLength {
            userAnswer.append("")
        }
        
        questionLabel.text = emoji
        if emoji.count < 5 {
            questionLabel.font = UIFont.systemFont(ofSize: 70)
        } else if emoji.count < 7 {
            questionLabel.font = UIFont.systemFont(ofSize: 50)
        } else {
            questionLabel.font = UIFont.systemFont(ofSize: 40)
        }
        
        if let favoriteButton = self.view.viewWithTag(500) as? UIButton {
            if isFavorite {
                favoriteButton.setImage(UIImage(named: "filledHeart"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "unfilledHeart"), for: .normal)
            }
        }
    }
    
    func setupView() {
        backgroundImage.frame = UIScreen.main.bounds
        answerView.backgroundColor = UIColor(red: 208/255.0, green: 211/255.0, blue: 217/255.0, alpha: 1.0)
        backgroundImage.image = UIImage(named: "background.png")
        memoImage.image = UIImage(named: "memo.png")
        navigationItem.title = "#\(questionNumber + 1)" // 수정
    }
    
    func nextQuestion() { // 수정
        questionNumber = questionNumber + 1
        navigationItem.title = "#\(questionNumber + 1)"
        moneyButton.setTitle(" \(money)", for: .normal)
        moneyButton.sizeToFit()
        
        setupCurrentQuestion()
        updateAnswerPool()
        removeAnswerBlock()
        setupAnswerBlock()
    }
    
    func setupToolBar() {
        let clear = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(removeAll)) // 수정
        clear.tintColor = UIColor.darkGray
        let hint = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(getHint))
        hint.tintColor = UIColor.darkGray
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil) // 수정
        share.tintColor = UIColor.darkGray
        let favorite = UIBarButtonItem(image: UIImage(named: "unfilledHeart.png"), style: .plain, target: self, action: #selector(toggleFavorite(_:)))
        favorite.tag = 500
        if isFavorite {
            favorite.image = UIImage(named: "filledHeart.png")
        }
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
    
    func setupAnswerBlock() { // 수정 - 답의 길이에 따라 달라져야함
        var button = UIButton()
        var fixedX = (Int(UIScreen.main.bounds.width) - 44 * answerLength) / (answerLength + 1)
        var x = fixedX
        var y = 323
        var count = 0
        
        if answerLength <= 6 {
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
                
                if isSolved {
                    button.setTitle(answer[count], for: .normal)
                }
                
                self.view.addSubview(button)
                x = x + fixedX + 44
                count = count + 1
            }
        } else {
            var firstLineLength = answerLength / 2
            if answer.contains(".") {
                let toRemove = answer.firstIndex(of: ".")!
                answer = answer.filter({$0 != "."})
                firstLineLength = toRemove
            }
            let firstFixedX = (Int(UIScreen.main.bounds.width) - 44 * firstLineLength) / (firstLineLength + 1)
            let secondLineLength = answerLength - firstLineLength
            let secondFixedX = (Int(UIScreen.main.bounds.width) - 44 * secondLineLength) / (secondLineLength + 1)
            x = firstFixedX
            y = 283
            count = 0
            
            for _ in 1...firstLineLength {
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
                
                if isSolved {
                    button.setTitle(answer[count], for: .normal)
                }
                
                self.view.addSubview(button)
                x = x + firstFixedX + 44
                count = count + 1
            }
            
            x = secondFixedX
            y = 337
            
            for _ in 1...secondLineLength {
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
                
                if isSolved {
                    button.setTitle(answer[count], for: .normal)
                }
                
                self.view.addSubview(button)
                x = x + secondFixedX + 44
                count = count + 1
            }
        }
    }
    
    func removeAnswerBlock() {
        for i in 100...112 {
            if let answerButton = self.view.viewWithTag(i) as? UIButton {
                answerButton.removeFromSuperview()
            }
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
        
        updateAnswerPool() // 수정
    }
    
    func updateAnswerPool() { // 테스트 해보아야 함
        answerPool.removeAll()
        var answerPoolQuestionBank = categoryQuestions.filter({$0.length == answerLength})
        answerPoolQuestionBank = answerPoolQuestionBank.shuffled()
        let answersNeeded = 14 / answerLength
        for i in 0...answersNeeded {
            answerPool += answerPoolQuestionBank[i].answer
        }
        
        var temp = [String]()
        let answerString = answer.filter({$0 != "."}).reduce("") {$0 + $1}
        for _ in 1...(14 - answerLength) {
            if answerString.isAlphanumeric() {
                temp.append(randomAlphabet())
            } else {
                temp.append(answerPool.randomElement()!)
            }
        }
        answerPool = temp
        answerPool += answer
        answerPool = answerPool.filter({$0 != "."})
        answerPool = answerPool.shuffled()
        
        for i in 200...(200+answerPool.count - 1) {
            if let poolButton = self.view.viewWithTag(i) as? UIButton {
                poolButton.setTitle(answerPool[i - 200], for: .normal)
            }
        }
    }
    
    func randomAlphabet() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0...0).map{ _ in letters.randomElement()! })
    }
    
    func checkIfCorrect() {
        if userAnswer == answer {
            questionLabel.text = "정답"
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1200), execute: {
                self.questionLabel.text = self.emoji
                self.removeAll()
                self.money = self.money + 5
                UserDefaults.standard.set(self.money, forKey: "money")
                
                self.saveSolved()
                
                self.nextQuestion()
                })
        }
    }
    
    func setupMoneyButton() {
        moneyButton.setImage(UIImage(named: "user.png"), for: .normal)
        moneyButton.setTitle(" \(money)", for: .normal)
        moneyButton.titleLabel?.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
        moneyButton.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moneyButton)
    }
    
    @objc func removeAll() {
        if !isSolved {
            userAnswer.removeAll()
            
            for _ in 1...answerLength {
                userAnswer.append("")
            }
            
            for j in 200...(200+answerPool.count) {
                if let poolButton = self.view.viewWithTag(j) as? UIButton {
                    poolButton.isEnabled = true
                    poolButton.isHidden = false
                }
            }
            
            for i in 100...(100+answerLength) {
                if let answerButton = self.view.viewWithTag(i) as? UIButton {
                    answerButton.setTitle(" ", for: .normal)
                    hiddenButtonTag.removeValue(forKey: answerButton.tag)
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
                    let text = poolButton.titleLabel?.text as? String ?? ""
                    userAnswer.remove(at: answerButton.tag - 100)
                    userAnswer.insert(text, at: (answerButton.tag - 100))
                    checkIfCorrect()
                    print(userAnswer, answer)
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
                    userAnswer.remove(at: key - 100)
                    userAnswer.insert("", at: key - 100)
                    answerButton.setTitle(" ", for: .normal)
                    poolButton.isHidden = false
                    hiddenButtonTag.removeValue(forKey: key)
                    print(userAnswer)
                }
            }
        }
    }
    
    @objc func getHint() {
        if self.money >= 50 {
            let alert = UIAlertController(title: "힌트 사용", message: "50 포인트를 감소하여 힌트를 사용하시겠습니까?", preferredStyle: .alert)
            let use = UIAlertAction(title: "사용", style: .default, handler: { _ in
                self.money = self.money - 50
                UserDefaults.standard.set(self.money, forKey: "money")
                self.moneyButton.setTitle(" \(self.money)", for: .normal)
                self.moneyButton.sizeToFit()
                
                for i in 100...(100+self.answerLength) {
                        if let answerButton = self.view.viewWithTag(i) as? UIButton {
                            if answerButton.titleLabel?.text == nil || answerButton.titleLabel?.text == " " {
                                answerButton.setTitle(self.answer[answerButton.tag - 100], for: .normal)
                                self.userAnswer.remove(at: answerButton.tag - 100)
                                self.userAnswer.insert(self.answer[answerButton.tag - 100], at: (answerButton.tag - 100))
                                for j in 200...(200+self.answerPool.count) {
                                    if let poolButton = self.view.viewWithTag(j) as? UIButton {
                                        if poolButton.titleLabel?.text == self.answer[answerButton.tag - 100] {
                                            poolButton.isEnabled = false
                                            poolButton.isHidden = true
                                        }
                                    }
                                }
                                self.checkIfCorrect()
                                print(self.userAnswer, self.answer)
                                break
                            }
                            continue
                        }
                    }
                })
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alert.addAction(use)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let noMoney = UIAlertController(title: "힌트를 보기에 돈이 부족합니다", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            noMoney.addAction(ok)
            self.present(noMoney, animated: true, completion: nil)
        }
    }
    
    @objc func toggleFavorite(_ favoriteButton: UIBarButtonItem) {
        isFavorite = !isFavorite
        
        if isFavorite {
            favoriteButton.image = UIImage(named: "filledHeart.png")
        }
        else {
            favoriteButton.image = UIImage(named: "unfilledHeart.png")
        }
        
        saveFavorite()
    }
    
    func saveFavorite() {
        categoryQuestions = categoryQuestions.filter({$0 != question})
        question.isFavorite = !question.isFavorite
        categoryQuestions.insert(question, at: questionNumber)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: categoryQuestions)
        
        if category == "KPOP" {
            UserDefaults.standard.set(data, forKey: "kpop")
        } else if category == "드라마" {
            UserDefaults.standard.set(data, forKey: "drama")
        } else if category == "영화" {
            UserDefaults.standard.set(data, forKey: "movie")
        } else if category == "커스텀" {
            UserDefaults.standard.set(data, forKey: "custom")
        }
    }
    
    func saveSolved() {
        categoryQuestions = categoryQuestions.filter({$0 != question})
        question.isSolved = true
        categoryQuestions.insert(question, at: questionNumber)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: categoryQuestions)
        
        if category == "KPOP" {
            UserDefaults.standard.set(data, forKey: "kpop")
        } else if category == "드라마" {
            UserDefaults.standard.set(data, forKey: "drama")
        } else if category == "영화" {
            UserDefaults.standard.set(data, forKey: "movie")
        } else if category == "커스텀" {
            UserDefaults.standard.set(data, forKey: "custom")
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
