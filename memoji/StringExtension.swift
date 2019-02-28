//
//  StringExtension.swift
//  memoji
//
//  Created by 옥재현 on 28/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import Foundation

extension String {
    func isAlphanumeric() -> Bool {
        let characterSet = CharacterSet(charactersIn: "ABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        return self.rangeOfCharacter(from: characterSet) != nil && self != ""
    }
}
