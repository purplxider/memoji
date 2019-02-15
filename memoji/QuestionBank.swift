//
//  QuestionBank.swift
//  memoji
//
//  Created by CAU on 15/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import Foundation

class QuestionBank {
    var list = [Question] ()
    
    init() {
        list.append(Question(emoji: "🐮🙏✋🙋‍♀️❤👉🙎‍♂️", length :3, answer:["거", "짓", "말"]))
//        list.append(Question(emoji: "🙏🙋‍♂️👉🏃‍♀️", length :2, answer:["고", "백"], answerPool:["바", "다", "박", "수", "싸", "이", "바", "코", "드"]))
//        list.append(Question(emoji: "🙋‍♂️❤️👩💨", length :5, answer:["그", "대", "가", "분", "댜"], answerPool:["바", "다", "박", "수", "싸", "이"]))
        
    }
}

