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
    @IBOutlet weak var saveButton: UIButton!
    
    var questionBank = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customData = UserDefaults.standard.object(forKey: "custom") as? Data {
            let customQuestions = NSKeyedUnarchiver.unarchiveObject(with: customData) as! [Question]
            questionBank += customQuestions
        }
        
        backgroundImage.image = UIImage(named: "background.png")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        if questionTextField.text != nil && answerTextField.text != nil {
            let questionText = questionTextField.text!
            let answerText = answerTextField.text!
            let answerArray = answerText.map({String($0)})
            let question = Question(emoji: questionText, length: answerText.count, answer: answerArray)
            questionBank.append(question)
            
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: questionBank)
            UserDefaults.standard.set(encodedData, forKey: "custom")
            
            dismiss(animated: true, completion: nil)
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
