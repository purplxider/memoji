//
//  DataCenter.swift
//  memoji
//
//  Created by CAU on 08/02/2019.
//  Copyright © 2019 purplxider. All rights reserved.
//

import Foundation

let kpopFileName = "KpopQuestions.pxr"
let dramaFileName = "DramaQuestions.pxr"
let movieFileName = "MovieQuestions.pxr"
let customFileName = "CustomQuestions.pxr"

class QuestionBank:NSObject, NSCoding {
    
    var kpopQuestions = [Question]()
    var dramaQuestions = [Question]()
    var movieQuestions = [Question]()
    var customQuestions = [Question]()
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.kpopQuestions, forKey: "kpopQuestions")
        aCoder.encode(self.dramaQuestions, forKey: "dramaQuestions")
        aCoder.encode(self.movieQuestions, forKey: "movieQuestions")
        aCoder.encode(self.customQuestions, forKey: "customQuestions")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.kpopQuestions = aDecoder.decodeObject(forKey: "kpopQuestions") as! [Question]
        self.dramaQuestions = aDecoder.decodeObject(forKey: "dramaQuestions") as! [Question]
        self.movieQuestions = aDecoder.decodeObject(forKey: "movieQuestions") as! [Question]
        self.customQuestions = aDecoder.decodeObject(forKey: "customQuestions") as! [Question]

    }
    
    override init() {
        super.init()
        
        if FileManager.default.fileExists(atPath: getFilePath(fileName: customFileName)) {
            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath(fileName: customFileName)) as? [Question] {
                customQuestions += unarchArray
            }
        }
        
        defaultKpopQuestions(questions: &kpopQuestions)
        defaultDramaQuestions(questions: &dramaQuestions)
        defaultMovieQuestions(questions: &movieQuestions)
    }
    
    func saveCustomQuestions() {
        NSKeyedArchiver.archiveRootObject(customQuestions, toFile: getFilePath(fileName: customFileName))
    }
    
    func defaultKpopQuestions(questions: inout [Question]) {
        questions.append(Question(emoji: "🔁🤝🌏", length: 6, answer: ["다", "시", "만", "난", "세", "계"]))
    }
    
    func defaultDramaQuestions(questions: inout [Question]) {
        questions.append(Question(emoji: "🔁🤝2", length: 6, answer: ["다", "시", "만", "난", "세", "계"]))
    }
    
    func defaultMovieQuestions(questions: inout [Question]) {
        questions.append(Question(emoji: "🔁🤝3", length: 6, answer: ["다", "시", "만", "난", "세", "계"]))
    }
    
    func getFilePath(fileName: String) -> String {
        var filePath:String { get {
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            return documentDirectory + fileName
            }}
        return filePath
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
