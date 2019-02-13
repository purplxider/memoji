//
//  DataCenter.swift
//  memoji
//
//  Created by CAU on 08/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import Foundation


class Question:NSObject, NSCoding {
    
    let emoji: String
    let length: Int
    let answer: [String]
    var answerPool: [String]
    
    init(emoji:String, length:Int, answer:[String], answerPool:[String]) {
        self.emoji = emoji
        self.length = length
        self.answer = answer
        self.answerPool = answerPool
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.emoji, forKey: "emoji")
        aCoder.encode(self.length, forKey: "length")
        aCoder.encode(self.answer, forKey: "answer")
        aCoder.encode(self.answerPool, forKey: "answerPool")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.emoji = aDecoder.decodeObject(forKey: "emoji") as! String
        self.length = aDecoder.decodeObject(forKey: "length") as! Int
        self.answer = aDecoder.decodeObject(forKey: "answer") as! [String]
        self.answerPool = aDecoder.decodeObject(forKey: "answerPool") as! [String]
    }
}
