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
    var isFavorite: Bool
    var isSolved: Bool
    
    init(emoji:String, length:Int, answer:[String]) {
        self.emoji = emoji
        self.length = length
        self.answer = answer
        self.isFavorite = false
        self.isSolved = false
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.emoji, forKey: "emoji")
        aCoder.encode(self.length, forKey: "length")
        aCoder.encode(self.answer, forKey: "answer")
        aCoder.encode(self.isFavorite, forKey: "isFavorite")
        aCoder.encode(self.isSolved, forKey: "isSolved")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.emoji = aDecoder.decodeObject(forKey: "emoji") as! String
        self.length = aDecoder.decodeInteger(forKey: "length")
        self.answer = aDecoder.decodeObject(forKey: "answer") as! [String]
        self.isFavorite = aDecoder.decodeBool(forKey: "isFavorite")
        self.isSolved = aDecoder.decodeBool(forKey: "isSolved")
    }
}
