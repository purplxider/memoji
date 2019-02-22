//
//  CustomQuestionViewController.swift
//  memoji
//
//  Created by CAU on 20/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class CustomQuestionViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var questionBank = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let customData = UserDefaults.standard.object(forKey: "custom") as? Data {
            let customQuestions = NSKeyedUnarchiver.unarchiveObject(with: customData) as! [Question]
            questionBank += customQuestions
        }
        
        backgroundImage.image = UIImage(named: "background.png")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveQuestion(_ sender: Any) {
        if questionTextField.text != "" && answerTextField.text != "" {
            if (answerTextField.text?.count)! > 6 {
                let alert = UIAlertController(title: "답을 6글자 미만으로 줄여주세요", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                let questionText = questionTextField.text!
                let answerText = answerTextField.text!
                let answerArray = answerText.map({String($0)})
                let question = Question(emoji: questionText, length: answerText.count, answer: answerArray)
                questionBank.append(question)
                
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: questionBank)
                UserDefaults.standard.set(encodedData, forKey: "custom")
                
                dismiss(animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "빈 칸을 채워주세요", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func cancelQuestion(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
