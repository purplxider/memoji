//
//  DataCenter.swift
//  memoji
//
//  Created by CAU on 08/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import Foundation


class Question:NSObject, NSCoding {
    
    let question: String
    let length: Int
    let answer: String
    var answerPool: [Character]
    
    init(question:String, length:Int, answer:String, answerPool:[Character]) {
        self.question = question
        self.length = length
        self.answer = answer
        self.answerPool = answerPool
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.question, forKey: "question")
        aCoder.encode(self.length, forKey: "length")
        aCoder.encode(self.answer, forKey: "answer")
        aCoder.encode(self.answerPool, forKey: "answerPool")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.question = aDecoder.decodeObject(forKey: "question") as! String
        self.length = aDecoder.decodeObject(forKey: "length") as! Int
        self.answer = aDecoder.decodeObject(forKey: "answer") as! String
        self.answerPool = aDecoder.decodeObject(forKey: "answerPool") as! [Character]
    }
}
