//
//  TextService.swift
//  Jacaranda Card POS
//
//  Created by weng chong lao on 25/11/2022.
//

import Foundation

class TextService {
    
    static func getStringByLength(text: String, length: Int) -> String {
        
        if text.count < length {
            return text
        }

        let lengthIndex = text.index(text.startIndex, offsetBy: 34)
        let substringRange = lengthIndex..<text.endIndex
        
        let substring = text[substringRange]
        let spaceIndex = substring.firstIndex(of: " ")
        
        if let replaceIndex = spaceIndex {
            let modifiedRange = text.startIndex..<replaceIndex
            let modifiedText = text[modifiedRange]
            return modifiedText + "..."
        }
        return text
    }
}
