//
//  AppDelegate.swift
//  memoji
//
//  Created by CAU on 07/02/2019.
//  Copyright © 2019 purplxider. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if UserDefaults.standard.object(forKey: "money") == nil {
            UserDefaults.standard.set(0, forKey: "money")
        }
        if UserDefaults.standard.object(forKey: "questionNumber") == nil {
            UserDefaults.standard.set(1, forKey: "questionNumber")
        }
        if UserDefaults.standard.object(forKey: "kpop") == nil {
            var questions = [Question]()
            questions.append(Question(emoji: "🔁🤝🌏", length: 6, answer: ["다", "시", "만", "난", "세", "계"]))
            questions.append(Question(emoji: "🐢", length: 3, answer: ["거", "북", "이"]))
            questions.append(Question(emoji: "🏃‍♀️✌👉", length: 8, answer: ["R", "U", "N", "T", "O", "Y", "O", "U"]))
            questions.append(Question(emoji: "🍦🎂", length: 12, answer: ["I", "C", "E", "C", "R", "E", "A", "M", "C", "A", "K", "E"]))
            questions.append(Question(emoji: "🙋‍♂️🦋", length: 4, answer: ["나", "는", "나", "비"]))
            questions.append(Question(emoji: "⬆️⬇️", length: 3, answer: ["위", "아", "래"]))
            questions.append(Question(emoji: "❌❌❌", length: 6, answer: ["N", "O", "N", "O", "N", "O"]))
            questions.append(Question(emoji: "😭❌", length: 6, answer: ["울", "고", "싶", "지", "않", "아"]))
            questions.append(Question(emoji: "💥💥💥", length: 3, answer: ["뱅", "뱅", "뱅"]))
            questions.append(Question(emoji: "🎁", length: 2, answer: ["선", "물"]))
            questions.append(Question(emoji: "🗣🙋", length: 6, answer: ["T", "E", "L", "L", "M", "E"]))
            questions.append(Question(emoji: "🔮", length: 4, answer: ["유", "리", "구", "슬"]))
            questions.append(Question(emoji: "🤵🏻💋", length: 5, answer: ["M", "R", "C", "H", "U"]))
            questions.append(Question(emoji: "👄💨", length: 3, answer: ["휘", "파", "람"]))
            questions.append(Question(emoji: "⭐️✨🌰", length: 6, answer: ["별", "이", "빛", "나", "는", "밤"]))
            questions.append(Question(emoji: "🐄👆🗣", length: 6, answer: ["소", "원", "을", "말", "해", "봐"]))
            questions.append(Question(emoji: "👉🙋👈", length: 6, answer: ["P", "I", "C", "K", "M", "E"]))
            questions.append(Question(emoji: "🧚‍♀️❌👼🏻", length: 6, answer: ["날", "개", "잃", "은", "천", "사"]))
            questions.append(Question(emoji: "🏠🔙🏃🏻‍♂️", length: 12, answer: ["C", "O", "M", "E", "B", "A", "C", "K", "H", "O", "M", "E"]))
            questions.append(Question(emoji: "🙏🙏", length: 10, answer: ["S", "O", "R", "R", "Y", "S", "O", "R", "R", "Y"]))
            questions.append(Question(emoji: "❤️🙅🏻‍♀️", length: 4, answer: ["사", "랑", "안", "해"]))
            questions.append(Question(emoji: "🌊", length: 2, answer: ["파", "도"]))
            questions.append(Question(emoji: "🚪🤛🚪🤛", length: 10, answer: ["K", "N", "O", "C", "K", "K", "N", "O", "C", "K"]))
            questions.append(Question(emoji: "❤️😷", length: 4, answer: ["사", "랑", "앓", "이"]))
            questions.append(Question(emoji: "👏🏻", length: 2, answer: ["박", "수"]))
            questions.append(Question(emoji: "🐟2⃣", length: 2, answer: ["어", "이"]))
            questions.append(Question(emoji: "🏃🏃🍞🍞", length: 4, answer: ["뛰", "뛰", "빵", "빵"]))
            questions.append(Question(emoji: "🦁❤️", length: 9, answer: ["L", "I", "O", "N", "H", "E", "A", "R", "T"]))
            questions.append(Question(emoji: "🐮🔥", length: 5, answer: ["S", "O", "H", "O", "T"]))
            questions.append(Question(emoji: "🤵🏻🚖", length: 6, answer: ["M", "R", "T", "A", "X", "I"]))
            questions.append(Question(emoji: "🌛💍", length: 2, answer: ["달", "링"]))
            questions.append(Question(emoji: "⏳🛑", length: 6, answer: ["시", "간", "아", "멈", "춰", "라"]))
            questions.append(Question(emoji: "🕺🤴", length: 3, answer: ["댄", "싱", "킹"]))
            questions.append(Question(emoji: "🌟💡🌛💡", length: 4, answer: ["별", "빛", "달", "빛"]))
            questions.append(Question(emoji: "👕👕", length: 2, answer: ["T", "T"]))
            questions.append(Question(emoji: "🍆⏰🙋", length: 3, answer: ["가", "시", "나"]))
            questions.append(Question(emoji: "⏰🏃", length: 6, answer: ["시", "간", "을", "달", "려", "서"]))
            questions.append(Question(emoji: "👍👋👶", length: 11, answer: ["G", "O", "O", "D", "B", "Y", "E", "B", "A", "B", "Y"]))
            questions.append(Question(emoji: "👀👃👄", length: 3, answer: ["눈", "코", "입"]))
            questions.append(Question(emoji: "💑❌", length: 6, answer: ["사", "랑", "하", "지", "마"]))
            questions.append(Question(emoji: "💋👉", length: 10, answer: ["K", "I", "S", "S", "I", "N", "G", "Y", "O", "U"]))
            questions.append(Question(emoji: "👉🙋👈", length: 6, answer: ["P", "I", "C", "K", "M", "E"]))
            questions.append(Question(emoji: "🏃👿🏃", length: 11, answer: ["R", "U", "N", "D", "E", "V", "I", "L", "R", "U", "N"]))
            questions.append(Question(emoji: "🌬🚪 🏋️‍♂️🐂", length: 7, answer: ["풍", "문", "으", "로", "들", "었", "소"]))
            questions.append(Question(emoji: "🌑🌒🌓🌔🌕💃", length: 8, answer: ["달", "이", "차", "오", "른", "다", "가", "자"]))
            questions.append(Question(emoji: "🍀👆", length: 8, answer: ["L", "U", "C", "K", "Y", "O", "N", "E"]))
            questions.append(Question(emoji: "👨🏻🤣", length: 4, answer: ["아", "재", "개", "그"]))
            questions.append(Question(emoji: "🍻⬆️👶", length: 7, answer: ["C", "H", "E", "E", "R", "U", "P"]))
            questions.append(Question(emoji: "🎤⬇", length: 7, answer: ["M", "I", "C", "D", "R", "O", "P"]))
            questions.append(Question(emoji: "🛌🗣", length: 3, answer: ["잠", "꼬", "대"]))
            questions.append(Question(emoji: "💗❔", length: 11, answer: ["W", "H", "A", "T", "I", "S", "L", "O", "V", "E", "?"]))
            questions.append(Question(emoji: "🤵👰🍆 💭🌞🐂", length: 8, answer: ["결", "혼", "까", "지", "생", "각", "했", "어"]))
            questions.append(Question(emoji: "❤️🙋‍♂️✔️", length: 11, answer: ["L", "O", "V", "E", "M", "E", "R", "I", "G", "H", "T"]))
            questions.append(Question(emoji: "👉🙋‍♂️👈", length: 3, answer: ["나", "야", "나"]))
            questions.append(Question(emoji: "📞🙋‍♂️👶", length: 10, answer: ["C", "A", "L", "L", "M", "E", "B", "A", "B", "Y"]))
            questions.append(Question(emoji: "🖐❌", length: 4, answer: ["손", "대", "지", "마"]))
            questions.append(Question(emoji: "🎤⬆️👍🏻", length: 6, answer: ["노", "래", "가", "늘", "었", "어"]))
            questions.append(Question(emoji: "👃👃🍚", length: 11, answer: ["K", "O", "K", "O", "B", "O", "P"]))
            questions.append(Question(emoji: "🌃💌", length: 3, answer: ["밤", "편", "지"]))
            questions.append(Question(emoji: "🍒💣", length: 10, answer: ["C", "H", "E", "R", "R", "Y", "B", "O", "M", "B"]))
            questions.append(Question(emoji: "😭🎤", length: 4, answer: ["슬", "픈", "노", "래"]))
            questions.append(Question(emoji: "✌🌟", length: 2, answer: ["이", "별"]))
            questions.append(Question(emoji: "🎹👨", length: 8, answer: ["P", "I", "A", "N", "O", "M", "A", "N"]))
            questions.append(Question(emoji: "🌸🛣", length: 2, answer: ["꽃", "길"]))
            questions.append(Question(emoji: "✌️🦀🤷‍♀️1️⃣❓", length: 7, answer: ["이", "게", "무", "슨", "일", "이", "야"]))
            questions.append(Question(emoji: "❤☔", length: 8, answer: ["L", "O", "V", "E", "R", "A", "I", "N"]))
            
            questions.append(Question(emoji: "🐮🙋🚩", length: 3, answer: ["소", "나", "기"]))

            questions.append(Question(emoji: "👦👦👉👦👈👦👦", length: 7, answer: ["다", "른", "남", "자", "말", "고", "너"]))
            questions.append(Question(emoji: "👍🍀", length: 8, answer: ["G", "O", "O", "D", "L", "U", "C", "K"]))
            questions.append(Question(emoji: "🍁📞", length: 4, answer: ["가", "을", "안", "부"]))
            questions.append(Question(emoji: "✌📗🔚🔁✍☀️", length: 12, answer: ["이", "소", "설", "설", "의", "끝", "을", "다", "시", "써", "보", "려", "해"]))
            questions.append(Question(emoji: "✋", length: 4, answer: ["F", "I", "V", "E"]))
            questions.append(Question(emoji: "☝❄", length: 2, answer: ["첫", "눈"]))
            questions.append(Question(emoji: "♨️👶🀄", length: 3, answer: ["열", "애", "중"]))
            questions.append(Question(emoji: "⛄", length: 3, answer: ["눈", "사", "람"]))
            questions.append(Question(emoji: "🕒🍵", length: 2, answer: ["시", "차"]))
            questions.append(Question(emoji: "🙋‍♂️🛣", length: 5, answer: ["M", "Y", "W", "A", "Y"]))
            questions.append(Question(emoji: "👶❓", length: 2, answer: ["애", "니"]))
            questions.append(Question(emoji: "🔚❤️", length: 3, answer: ["끝", "사", "랑"]))
            questions.append(Question(emoji: "🛌❔", length: 2, answer: ["자", "니"]))
            questions.append(Question(emoji: "👍👀", length: 4, answer: ["좋", "아", "보", "여"]))
            questions.append(Question(emoji: "✌️🌃🔚", length: 4, answer: ["이", "밤", "의", "끝"]))
            questions.append(Question(emoji: "💪👧", length: 3, answer: ["쎈", "언", "니"]))
            questions.append(Question(emoji: "📞🎤", length: 3, answer: ["폰", "서", "트"]))
            questions.append(Question(emoji: "🤥❤️", length: 8, answer: ["F", "A", "K", "E", "L", "O", "V", "E"]))
            questions.append(Question(emoji: "🙋‍♂️🔫🏃‍♂️", length: 5, answer: ["날", "쏘", "고", "가", "라"]))
            questions.append(Question(emoji: "🗣🛣", length: 6, answer: ["말", "하", "는", "대", "로"]))
            questions.append(Question(emoji: "👍🚪🚶‍♀️👌", length: 6, answer: ["잘", "나", "가", "서", "그", "래"]))
            questions.append(Question(emoji: "❤️🔋", length: 6, answer: ["사", "랑", "의", "배", "터", "리"]))
            questions.append(Question(emoji: "☺🌸", length: 3, answer: ["웃", "음", "꽃"]))
            questions.append(Question(emoji: "📞❓", length: 4, answer: ["여", "보", "세", "요"]))
            questions.append(Question(emoji: "😶😣🙅🏻‍♀️", length: 9, answer: ["얼", "굴", "찌", "푸", "리", "지", "말", "아", "요"]))
            questions.append(Question(emoji: "👈🏻🍜👌🏻", length: 6, answer: ["너", "라", "면", "괜", "찮", "아"]))
            questions.append(Question(emoji: "🗼👧", length: 7, answer: ["T", "O", "P", "G", "I", "R", "L"]))
            questions.append(Question(emoji: "💪❗", length: 3, answer: ["힘", "내", "!"]))
            questions.append(Question(emoji: "☝🙅", length: 4, answer: ["1", "도", "없", "어"]))
            questions.append(Question(emoji: "🐴🏃‍♀️", length: 4, answer: ["말", "달", "리", "자"]))
            questions.append(Question(emoji: "🔔🔊", length: 3, answer: ["종", "소", "리"]))
            questions.append(Question(emoji: "👧🔁👩", length: 7, answer: ["N", "E", "W", "F", "A", "C", "E"]))
            questions.append(Question(emoji: "👨💖🕑", length: 7, answer: ["남", "자", "가", "사", "랑", "할", "때"]))
            questions.append(Question(emoji: "😁😁😁🎤", length: 4, answer: ["하", "하", "하", "쏭"]))
            questions.append(Question(emoji: "🍂🌅", length: 4, answer: ["가", "을", "아", "침"]))
            questions.append(Question(emoji: "🚌⬅️", length: 5, answer: ["버", "스", "안", "에", "서"]))
            questions.append(Question(emoji: "🍊☀️🍊🌙", length: 5, answer: ["오", "랜", "날", "오", "랜", "밤"]))
            questions.append(Question(emoji: "❤️ 🎵", length: 8, answer: ["L", "O", "V", "E", "S", "O", "N", "G"]))
            questions.append(Question(emoji: "👩💭🚶‍♀️🕒🕕🕘🕛", length: 7, answer: ["기", "억", "을", "걷", "는", "시", "간"]))
            questions.append(Question(emoji: "🙋‍♀️👂🍬", length: 5, answer: ["내", "귀", "에", "캔", "디"]))
            questions.append(Question(emoji: "💘🐎🌞", length: 5, answer: ["좋", "다", "고", "말", "해"]))
            questions.append(Question(emoji: "❤️🎤=💔🎤", length: 10, answer: ["사", "랑", "노", "래", "같", "은", "이", "별", "노", "래"]))
            questions.append(Question(emoji: "🔊⬆️", length: 8, answer: ["V", "O", "L", "U", "M", "E", "U", "P"]))
            questions.append(Question(emoji: "🎶🔥", length: 3, answer: ["리", "듬", "타"]))
            questions.append(Question(emoji: "📏☀️", length: 3, answer: ["센", "치", "해"]))
            questions.append(Question(emoji: "🐮😭👭", length: 5, answer: ["소", "울", "메", "이", "트"]))
            questions.append(Question(emoji: "💡🌼🚪", length: 5, answer: ["광", "화", "문", "에", "서"]))
            questions.append(Question(emoji: "🍁🔥👁", length: 5, answer: ["가", "을", "타", "나", "봐"]))
            questions.append(Question(emoji: "👧🙅🙆🙅🙆", length: 4, answer: ["X", "O", "X", "O"]))
            questions.append(Question(emoji: "🌥🌻", length: 5, answer: ["하", "늘", "바", "라", "기"]))
            questions.append(Question(emoji: "🌊🤴", length: 5, answer: ["바", "다", "의", "왕", "자"]))
            questions.append(Question(emoji: "🌙✨🏖", length: 4, answer: ["달", "빛", "바", "다"]))
            questions.append(Question(emoji: "🐍 ", length: 4, answer: ["B", "A", "A", "M"]))
            questions.append(Question(emoji: "🙋 🗣👂", length: 6, answer: ["내", "얘", "길", "들", "어", "봐"]))
            questions.append(Question(emoji: "😭🎤", length: 4, answer: ["슬", "픈", "노", "래"]))
            questions.append(Question(emoji: "🌞💩🚗", length: 6, answer: ["해", "변", "으", "로", "가", "요"]))
            questions.append(Question(emoji: "👍👍👍👍👍👍", length: 7, answer: ["아", "주", "N", "I", "C", "E"]))
            questions.append(Question(emoji: "💏💑", length: 3, answer: ["두", "사", "랑"]))
            questions.append(Question(emoji: "🌊🤴", length: 5, answer: ["바", "다", "의", "왕", "자"]))
            questions.append(Question(emoji: "❄️🍜", length: 2, answer: ["냉", "면"]))
            questions.append(Question(emoji: "🔃🔄", length: 4, answer: ["빙", "글", "뱅", "글"]))
            questions.append(Question(emoji: "😢😢", length: 5, answer: ["T", "E", "A", "R", "S"]))
            questions.append(Question(emoji: "🍺🥜", length: 5, answer: ["맥", "주", "와", "땅", "콩"]))
            questions.append(Question(emoji: "☀️💩👩🏻", length: 5, answer: ["해", "변", "의", "여", "인"]))
            questions.append(Question(emoji: "👶🏆", length: 2, answer: ["애", "상"]))
            questions.append(Question(emoji: "👥👍✌️🎉 ", length: 12, answer: ["W", "E", "L", "I", "K", "E", "T", "O", "P", "A", "R", "T", "Y"]))

            questions.append(Question(emoji: "❌💑", length: 5, answer: ["잘", "못", "된", "만", "남"]))
            questions.append(Question(emoji: "🏥🚑", length: 3, answer: ["응", "급", "실"]))
            questions.append(Question(emoji: "💏💑", length: 3, answer: ["두", "사", "랑"]))
            questions.append(Question(emoji: "🐎☀️🤲", length: 3, answer: ["말", "해", "줘"]))
            questions.append(Question(emoji: "🗣👍🏻👎🏻", length: 9, answer: ["말", "해", "Y", "E", "S", "O", "R", "N", "O"]))
            questions.append(Question(emoji: "📺🔌", length: 5, answer: ["T", "V", "를", "껐", "네"]))
            questions.append(Question(emoji: "🌸🔚", length: 4, answer: ["벚", "꽃", "엔", "딩"]))
            questions.append(Question(emoji: "👶🏻🦈", length: 4, answer: ["아", "기", "상", "어"]))
            questions.append(Question(emoji: "👶👑", length: 4, answer: ["어", "린", "왕", "자"]))
            questions.append(Question(emoji: "👢🐈", length: 7, answer: ["장", "화", "신", "은", "고", "양", "이"]))

            let data = NSKeyedArchiver.archivedData(withRootObject: questions)
            UserDefaults.standard.set(data, forKey: "kpop")
        }
        if UserDefaults.standard.object(forKey: "drama") == nil {
            var questions = [Question]()
            questions.append(Question(emoji: "🔁🤝2", length: 3, answer: ["다", "시", "만"]))
            let data = NSKeyedArchiver.archivedData(withRootObject: questions)
            UserDefaults.standard.set(data, forKey: "drama")
        }
        if UserDefaults.standard.object(forKey: "movie") == nil {
            var questions = [Question]()
            questions.append(Question(emoji: "🔁🤝3", length: 4, answer: ["다", "시", "만", "난"]))
            let data = NSKeyedArchiver.archivedData(withRootObject: questions)
            UserDefaults.standard.set(data, forKey: "movie")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

