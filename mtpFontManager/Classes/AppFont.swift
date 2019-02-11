//
//  FontName.swift
//  mtpFontManager
//
//  Created by Mostafa Taghipour on 2/5/19.
//

import Foundation

/// Font name struct
public struct AppFont {
    public let id: Int
    public let familyName: String
    public let defaultFont: String
    public var ultraLight: String?
    public var thin: String?
    public var light: String?
    public var regular: String?
    public var medium: String?
    public var semibold: String?
    public var bold: String?
    public var heavy: String?
    public var black: String?

    public init(id: Int,
                familyName: String,
                defaultFont: String) {
        self.id = id
        self.familyName = familyName
        self.defaultFont = defaultFont
    }

    public init(id: Int,
                familyName: String,
                defaultFont: String,
                ultraLight: String?,
                thin: String?,
                light: String?,
                regular: String?,
                medium: String?,
                semibold: String?,
                bold: String?,
                heavy: String?,
                black: String?) {
        self.id = id
        self.familyName = familyName
        self.defaultFont = defaultFont
        self.ultraLight = ultraLight
        self.thin = thin
        self.light = light
        self.regular = regular
        self.medium = medium
        self.semibold = semibold
        self.bold = bold
        self.heavy = heavy
        self.black = black
    }
    
    public init(plist: String) {
        guard let path = Bundle.main.path(forResource: plist, ofType: Constants.plistType),
            let dict = NSDictionary(contentsOfFile: path) as? [String: Any],
            let id = dict[ci: Constants.fontIdFiled] as? Int,
            let name = dict[ci: Constants.fontFamilyNameFiled] as? String,
            let defaultFont = dict[ci: Constants.fontDefaultFiled] as? String
            else {
              fatalError("plist is not correct")
        }
        
        self.id = id
        self.familyName = name
        self.defaultFont = defaultFont
        
        self.ultraLight = dict[ci: UIFont.Weight.ultraLight.title] as? String
        self.thin = dict[ci: UIFont.Weight.thin.title] as? String
        self.light = dict[ci: UIFont.Weight.light.title] as? String
        self.regular = dict[ci: UIFont.Weight.regular.title] as? String
        self.medium = dict[ci: UIFont.Weight.medium.title] as? String
        self.semibold = dict[ci: UIFont.Weight.semibold.title] as? String
        self.bold = dict[ci: UIFont.Weight.bold.title] as? String
        self.heavy = dict[ci: UIFont.Weight.heavy.title] as? String
        self.black = dict[ci: UIFont.Weight.black.title] as? String
    }
}
