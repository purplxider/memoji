//
//  DataCenter.swift
//  memoji
//
//  Created by CAU on 08/02/2019.
//  Copyright © 2019 purplxider. All rights reserved.
//

import Foundation

let fileName = "Questions.pxr"

class QuestionBank:NSObject, NSCoding {
    
    var questions = [Question]()
    
    var filePath:String { get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + fileName
        }}
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.questions, forKey: "questions")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.questions = aDecoder.decodeObject(forKey: "questions") as! [Question]
    }
    
    override init() {
        super.init()
        
        if FileManager.default.fileExists(atPath: filePath) {
            // 수정 - 읽기
            do {
                let rawData = try Data(contentsOf: URL(string: filePath)!)
                if let unarchArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(rawData) as? [Question] {
                    questions += unarchArray
                }
            } catch {
                
            }
        } else {
            questions.append(Question(emoji: "🔁🤝🌏", length: 6, answer: ["다", "시", "만", "난", "세", "계"]))
        }
    }
    
    func save() {
        do {
        let data = try NSKeyedArchiver.archivedData(withRootObject: questions, requiringSecureCoding: false)
            try data.write(to: URL(string: filePath)!)
        } catch {
            
        }
    }
}

class Question:NSObject, NSCoding {
    
    let emoji: String
    let length: Int
    let answer: [String]
    
    init(emoji:String, length:Int, answer:[String]) {
        self.emoji = emoji
        self.length = length
        self.answer = answer
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.emoji, forKey: "emoji")
        aCoder.encode(self.length, forKey: "length")
        aCoder.encode(self.answer, forKey: "answer")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.emoji = aDecoder.decodeObject(forKey: "emoji") as! String
        self.length = aDecoder.decodeObject(forKey: "length") as! Int
        self.answer = aDecoder.decodeObject(forKey: "answer") as! [String]
    }
}
