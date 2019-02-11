//
//  Helpers.swift
//  mtpFontManager
//
//  Created by Mostafa Taghipour on 2/5/19.
//

import Foundation


// MARK: - case insensitive dictionary
extension Dictionary where Key : ExpressibleByStringLiteral {
    subscript(ci key : Key) -> Value? {
        get {
            let searchKey = String(describing: key).lowercased()
            for k in self.keys {
                let lowerK = String(describing: k).lowercased()
                if searchKey == lowerK {
                    return self[k]
                }
            }
            return nil
        }
    }
}



// Helper function inserted by Swift 4.2 migrator.
func convertFromOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [String : Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key, value)})
}
