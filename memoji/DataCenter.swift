//
//  DataCenter.swift
//  memoji
//
//  Created by CAU on 08/02/2019.
//  Copyright © 2019 purplxider. All rights reserved.
//

import Foundation

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
        self.length = aDecoder.decodeInteger(forKey: "length")
        self.answer = aDecoder.decodeObject(forKey: "answer") as! [String]
    }
}
