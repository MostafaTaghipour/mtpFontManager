//
//  FontManager.swift
//  test
//
//  Created by Mostafa Taghipour on 9/15/17.
//  Copyright © 2017 Mostafa Taghipour. All rights reserved.
//

import UIKit

public class FontManager {
    public class func setFont(fontName:FontName){
        AppFont.shared.setFontName(bye: fontName)
        setup()
    }
    
    public class func setFont(plist:String){
        AppFont.shared.setFontName(bye: plist)
        setup()
    }
    
    private class func setup(){
        guard AppFont.shared.isSet else {
            return
        }
        
        UIFont.overrideInitialize()
        applyFontToDynamicTypes()
    }
    
    
    /// Apply font to Dynamic Types according https://developer.apple.com/ios/human-interface-guidelines/visual-design/typography/
    private class func applyFontToDynamicTypes(){
        
        var config = StyleConfig()
        
        //label
        config.label[UIFontTextStyle.body.rawValue] = AppFont.shared.Regular
        config.label[UIFontTextStyle.caption1.rawValue] = AppFont.shared.Regular
        config.label[UIFontTextStyle.caption2.rawValue] = AppFont.shared.Regular
        config.label[UIFontTextStyle.footnote.rawValue] = AppFont.shared.Regular
        config.label[UIFontTextStyle.headline.rawValue] = AppFont.shared.Semibold
        config.label[UIFontTextStyle.subheadline.rawValue] = AppFont.shared.Regular
        if #available(iOS 9.0, *) {
            config.label[UIFontTextStyle.callout.rawValue] = AppFont.shared.Regular
            config.label[UIFontTextStyle.title1.rawValue] = AppFont.shared.Regular
            config.label[UIFontTextStyle.title2.rawValue] = AppFont.shared.Regular
            config.label[UIFontTextStyle.title3.rawValue] = AppFont.shared.Regular
        }
        
        //textView
        config.textView[UIFontTextStyle.body.rawValue] = AppFont.shared.Regular
        config.textView[UIFontTextStyle.caption1.rawValue] = AppFont.shared.Regular
        config.textView[UIFontTextStyle.caption2.rawValue] = AppFont.shared.Regular
        config.textView[UIFontTextStyle.footnote.rawValue] = AppFont.shared.Regular
        config.textView[UIFontTextStyle.headline.rawValue] = AppFont.shared.Semibold
        config.textView[UIFontTextStyle.subheadline.rawValue] = AppFont.shared.Regular
        if #available(iOS 9.0, *) {
            config.textView[UIFontTextStyle.title1.rawValue] = AppFont.shared.Regular
            config.textView[UIFontTextStyle.title2.rawValue] = AppFont.shared.Regular
            config.textView[UIFontTextStyle.title3.rawValue] = AppFont.shared.Regular
            config.textView[UIFontTextStyle.callout.rawValue] = AppFont.shared.Regular
        }
        
        //textField
        config.textField[UIFontTextStyle.body.rawValue] = AppFont.shared.Regular
        config.textField[UIFontTextStyle.caption1.rawValue] = AppFont.shared.Regular
        config.textField[UIFontTextStyle.caption2.rawValue] = AppFont.shared.Regular
        config.textField[UIFontTextStyle.footnote.rawValue] = AppFont.shared.Regular
        config.textField[UIFontTextStyle.headline.rawValue] = AppFont.shared.Semibold
        config.textField[UIFontTextStyle.subheadline.rawValue] = AppFont.shared.Regular
        if #available(iOS 9.0, *) {
            config.textField[UIFontTextStyle.title1.rawValue] = AppFont.shared.Regular
            config.textField[UIFontTextStyle.title2.rawValue] = AppFont.shared.Regular
            config.textField[UIFontTextStyle.title3.rawValue] = AppFont.shared.Regular
            config.textField[UIFontTextStyle.callout.rawValue] = AppFont.shared.Regular
        }
        
        //button
        config.button[UIFontTextStyle.body.rawValue] = AppFont.shared.Regular
        config.button[UIFontTextStyle.caption1.rawValue] = AppFont.shared.Regular
        config.button[UIFontTextStyle.caption2.rawValue] = AppFont.shared.Regular
        config.button[UIFontTextStyle.footnote.rawValue] = AppFont.shared.Regular
        config.button[UIFontTextStyle.headline.rawValue] = AppFont.shared.Semibold
        config.button[UIFontTextStyle.subheadline.rawValue] = AppFont.shared.Regular
        if #available(iOS 9.0, *) {
            config.button[UIFontTextStyle.title1.rawValue] = AppFont.shared.Regular
            config.button[UIFontTextStyle.title2.rawValue] = AppFont.shared.Regular
            config.button[UIFontTextStyle.title3.rawValue] = AppFont.shared.Regular
            config.button[UIFontTextStyle.callout.rawValue] = AppFont.shared.Regular
        }
        
        StyleWatcher.defaultConfig = config
    }
}

// MARK: - define title property for UIFont.Weight
public extension UIFont.Weight {
    var title:String{
        switch self {
        case .ultraLight:
            return "Ultra Light"
        case .thin:
            return "Thin"
        case .light:
            return "Light"
        case .regular:
            return "Regular"
        case .medium:
            return "Medium"
        case .semibold:
            return "Semibold"
        case .bold:
            return "Bold"
        case .heavy:
            return "Heavy"
        case .black:
            return "Black"
        default:
            return ""
        }
    }
}

/// Font name struct
public struct FontName {
    var Ultra_Light:String?
    var Thin:String?
    var Light:String?
    var Regular:String?
    var Medium:String?
    var Semibold:String?
    var Bold:String?
    var Heavy:String?
    var Black:String?
}



/// App font Singelton
public class AppFont {
    var Ultra_Light=""
    var Thin=""
    var Light=""
    var Regular=""
    var Medium=""
    var Semibold=""
    var Bold=""
    var Heavy=""
    var Black=""
    
    static let shared = AppFont()
    
    private init(){
        
    }
    
    
    func setFontName(bye fontName:FontName)  {
        
        //main font
        self.Regular=fontName.Regular ?? ""
        
        self.Ultra_Light=fontName.Ultra_Light ?? self.Regular
        self.Thin=fontName.Thin ?? self.Regular
        self.Light=fontName.Light ?? self.Regular
        self.Medium=fontName.Medium ?? self.Regular
        self.Semibold=fontName.Semibold ?? self.Regular
        self.Bold=fontName.Bold ?? self.Regular
        self.Heavy=fontName.Heavy ?? self.Regular
        self.Black=fontName.Black ?? self.Regular
    }
    
    
    func setFontName(bye plist:String)  {
        
        if let path = Bundle.main.path(forResource: plist, ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
            
            //main font
            self.Regular=dict[ci: UIFont.Weight.regular.title] ?? ""
            
            self.Ultra_Light=dict[ci:UIFont.Weight.ultraLight.title] ?? self.Regular
            self.Thin=dict[ci:UIFont.Weight.thin.title] ?? self.Regular
            self.Light=dict[ci:UIFont.Weight.light.title] ?? self.Regular
            self.Medium=dict[ci:UIFont.Weight.medium.title] ?? self.Regular
            self.Semibold=dict[ci:UIFont.Weight.semibold.title] ?? self.Regular
            self.Bold=dict[ci:UIFont.Weight.bold.title] ?? self.Regular
            self.Heavy=dict[ci:UIFont.Weight.heavy.title] ?? self.Regular
            self.Black=dict[ci:UIFont.Weight.black.title] ?? self.Regular
        }
        
    }
    
    var isSet : Bool{
        get{
            return !Regular.isEmpty && UIFont.contains(fontWith: Regular)
        }
    }
    
}


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


// MARK: - define contains method for UIFont Class
public extension UIFont {
    
    public class func contains(fontWith name:String) -> Bool{
        for family in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: family) {
                if fontName==name{
                    return true
                }
            }
        }
        return false
    }
}

// MARK: - Swizzling systemFont with customFont
extension UIFont {
    
    @objc private class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFont.shared.Regular, size: size)!
    }
    
    @objc private class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFont.shared.Bold, size: size)!
    }
    
    //    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
    //        return UIFont(name: AppFontName.italic, size: size)!
    //    }
    
    @objc private class func mySystemFont(ofSize size:CGFloat ,weight:UIFont.Weight) -> UIFont {
        var fontName = AppFont.shared.Regular
        
        switch weight {
        case .ultraLight:
            fontName=AppFont.shared.Ultra_Light
            break
        case .thin:
            fontName=AppFont.shared.Thin
            break
        case .light:
            fontName=AppFont.shared.Light
            break
        case .regular:
            fontName=AppFont.shared.Regular
            break
        case .medium:
            fontName=AppFont.shared.Medium
            break
        case .semibold:
            fontName=AppFont.shared.Semibold
            break
        case .bold:
            fontName=AppFont.shared.Bold
            break
        case .heavy:
            fontName=AppFont.shared.Heavy
            break
        case .black:
            fontName=AppFont.shared.Black
            break
        default:
            fontName = AppFont.shared.Regular
            break
        }
        
        return UIFont(name: fontName, size: size)!
    }
    
    
    // override system font in IB
    @objc private convenience init(myCoder aDecoder: NSCoder) {
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            let fontAttr = UIFontDescriptor.AttributeName("NSCTFontUIUsageAttribute")
            if let fontAttribute = fontDescriptor.fontAttributes[fontAttr] as? String {
                var fontName = ""
                switch fontAttribute {
                case "CTFontUltraLightUsage":
                    fontName = AppFont.shared.Ultra_Light
                case "CTFontThinUsage":
                    fontName = AppFont.shared.Thin
                case "CTFontLightUsage":
                    fontName = AppFont.shared.Light
                case "CTFontRegularUsage":
                    fontName = AppFont.shared.Regular
                case "CTFontMediumUsage":
                    fontName = AppFont.shared.Medium
                case "CTFontDemiUsage":
                    fontName = AppFont.shared.Semibold
                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                    fontName = AppFont.shared.Bold
                case "CTFontHeavyUsage":
                    fontName = AppFont.shared.Heavy
                case "CTFontBlackUsage":
                    fontName = AppFont.shared.Black
                    //                case "CTFontObliqueUsage":
                //                    fontName = AppFontName.italic
                default:
                    fontName = AppFont.shared.Regular
                }
                self.init(name: fontName, size: fontDescriptor.pointSize)!
            }
            else {
                self.init(myCoder: aDecoder)
            }
        }
        else {
            self.init(myCoder: aDecoder)
        }
    }
    
    class fileprivate func overrideInitialize() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
            
            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
            
            //            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            //            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:)))
            //            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
            
            let systemFontWeightMethod = class_getClassMethod(self, #selector(systemFont(ofSize:weight:)))
            let mySystemFontWeightMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:weight:)))
            method_exchangeImplementations(systemFontWeightMethod, mySystemFontWeightMethod)
            
            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))) // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
