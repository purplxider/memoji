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
    
    // 기본적으로 필요한 변수
    var question = Question(emoji: "🔁🤝🌏", length: 6, answer: ["다", "시", "만", "난", "세", "계"], answerPool: ["다", "단", "만", "싱", "가", "계", "맘", "난", "시", "말", "낙", "세", "셀", "날"])
    var money = UserDefaults.standard.integer(forKey: "money")
    var questionNumber = UserDefaults.standard.integer(forKey: "questionNumber")
    let moneyButton = UIButton(type: .system)
    
    // 문제가 바뀔 때 업데이트 해줘야하는 값
    var emoji = String()
    var answerPool = [String]()
    var answer = [String]()
    var answerLength = Int()
    var userAnswer = [String]()
    var hiddenButtonTag = [Int:Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emoji = question.emoji
        answerPool = question.answerPool
        answer = question.answer
        answerLength = question.length
        
        // 화면 구성 셋업
        setupView()
        setupToolBar()
        setupAnswerPool()
        setupAnswerBlock()
        setupQuestion()
        setupMoneyButton()
    }
    
    // 각종 함수들입니다
    
    func setupView() {
        backgroundImage.frame = UIScreen.main.bounds
        answerView.backgroundColor = UIColor(red: 208/255.0, green: 211/255.0, blue: 217/255.0, alpha: 1.0)
        backgroundImage.image = UIImage(named: "background.png")
        memoImage.image = UIImage(named: "memo.png")
        navigationItem.title = "#\(questionNumber)" // 수정
    }
    
    func nextQuestion() { // 수정
        questionNumber = questionNumber + 1
        UserDefaults.standard.set(questionNumber, forKey: "questionNumber")
        navigationItem.title = "#\(questionNumber)"
        moneyButton.setTitle(" \(money)", for: .normal)
        moneyButton.sizeToFit()
    }
    
    func setupToolBar() {
        let clear = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(removeAll)) // 수정
        clear.tintColor = UIColor.darkGray
        let hint = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(getHint))
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
    
    func setupAnswerBlock() { // 수정 - 답의 길이에 따라 달라져야함
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
        questionLabel.text = emoji
    }
    
    func checkIfCorrect() {
        if userAnswer == answer {
            questionLabel.text = "정답"
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                self.questionLabel.text = self.emoji
                self.removeAll()
                self.money = self.money + 10
                UserDefaults.standard.set(self.money + 10, forKey: "money")
                self.nextQuestion()
                })
        }
    }
    
    func setupMoneyButton() {
        moneyButton.setImage(UIImage(named: "user.png"), for: .normal)
        moneyButton.setTitle(" \(money)", for: .normal)
        moneyButton.titleLabel?.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
        //moneyButton.titleLabel?.tintColor = UIColor(red: 228/255.0, green: 175/255.0, blue: 10/255.0, alpha: 1.0)
        moneyButton.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moneyButton)
    }
    
    @objc func removeAll() {
        userAnswer.removeAll()
        
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
    
    @objc func selectAnswer(_ poolButton: UIButton) {
        for i in 100...(100+answerLength) {
            if let answerButton = self.view.viewWithTag(i) as? UIButton {
                if answerButton.titleLabel?.text == nil || answerButton.titleLabel?.text == " " {
                    answerButton.setTitle(poolButton.titleLabel?.text, for: .normal)
                    poolButton.isHidden = true
                    hiddenButtonTag[answerButton.tag] = poolButton.tag
                    let text = poolButton.titleLabel?.text as! String
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
                    answerButton.setTitle(" ", for: .normal)
                    userAnswer.remove(at: answerButton.tag - 100)
                    poolButton.isHidden = false
                    hiddenButtonTag.removeValue(forKey: key)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
