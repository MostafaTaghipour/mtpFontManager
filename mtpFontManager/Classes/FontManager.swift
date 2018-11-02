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
        config.label[UIFont.TextStyle.body.rawValue] = AppFont.shared.Regular
        config.label[UIFont.TextStyle.caption1.rawValue] = AppFont.shared.Regular
        config.label[UIFont.TextStyle.caption2.rawValue] = AppFont.shared.Regular
        config.label[UIFont.TextStyle.footnote.rawValue] = AppFont.shared.Regular
        config.label[UIFont.TextStyle.headline.rawValue] = AppFont.shared.Semibold
        config.label[UIFont.TextStyle.subheadline.rawValue] = AppFont.shared.Regular
        if #available(iOS 9.0, *) {
            config.label[UIFont.TextStyle.callout.rawValue] = AppFont.shared.Regular
            config.label[UIFont.TextStyle.title1.rawValue] = AppFont.shared.Regular
            config.label[UIFont.TextStyle.title2.rawValue] = AppFont.shared.Regular
            config.label[UIFont.TextStyle.title3.rawValue] = AppFont.shared.Regular
        }
        
        //textView
        config.textView[UIFont.TextStyle.body.rawValue] = AppFont.shared.Regular
        config.textView[UIFont.TextStyle.caption1.rawValue] = AppFont.shared.Regular
        config.textView[UIFont.TextStyle.caption2.rawValue] = AppFont.shared.Regular
        config.textView[UIFont.TextStyle.footnote.rawValue] = AppFont.shared.Regular
        config.textView[UIFont.TextStyle.headline.rawValue] = AppFont.shared.Semibold
        config.textView[UIFont.TextStyle.subheadline.rawValue] = AppFont.shared.Regular
        if #available(iOS 9.0, *) {
            config.textView[UIFont.TextStyle.title1.rawValue] = AppFont.shared.Regular
            config.textView[UIFont.TextStyle.title2.rawValue] = AppFont.shared.Regular
            config.textView[UIFont.TextStyle.title3.rawValue] = AppFont.shared.Regular
            config.textView[UIFont.TextStyle.callout.rawValue] = AppFont.shared.Regular
        }
        
        //textField
        config.textField[UIFont.TextStyle.body.rawValue] = AppFont.shared.Regular
        config.textField[UIFont.TextStyle.caption1.rawValue] = AppFont.shared.Regular
        config.textField[UIFont.TextStyle.caption2.rawValue] = AppFont.shared.Regular
        config.textField[UIFont.TextStyle.footnote.rawValue] = AppFont.shared.Regular
        config.textField[UIFont.TextStyle.headline.rawValue] = AppFont.shared.Semibold
        config.textField[UIFont.TextStyle.subheadline.rawValue] = AppFont.shared.Regular
        if #available(iOS 9.0, *) {
            config.textField[UIFont.TextStyle.title1.rawValue] = AppFont.shared.Regular
            config.textField[UIFont.TextStyle.title2.rawValue] = AppFont.shared.Regular
            config.textField[UIFont.TextStyle.title3.rawValue] = AppFont.shared.Regular
            config.textField[UIFont.TextStyle.callout.rawValue] = AppFont.shared.Regular
        }
        
        //button
        config.button[UIFont.TextStyle.body.rawValue] = AppFont.shared.Regular
        config.button[UIFont.TextStyle.caption1.rawValue] = AppFont.shared.Regular
        config.button[UIFont.TextStyle.caption2.rawValue] = AppFont.shared.Regular
        config.button[UIFont.TextStyle.footnote.rawValue] = AppFont.shared.Regular
        config.button[UIFont.TextStyle.headline.rawValue] = AppFont.shared.Semibold
        config.button[UIFont.TextStyle.subheadline.rawValue] = AppFont.shared.Regular
        if #available(iOS 9.0, *) {
            config.button[UIFont.TextStyle.title1.rawValue] = AppFont.shared.Regular
            config.button[UIFont.TextStyle.title2.rawValue] = AppFont.shared.Regular
            config.button[UIFont.TextStyle.title3.rawValue] = AppFont.shared.Regular
            config.button[UIFont.TextStyle.callout.rawValue] = AppFont.shared.Regular
        }
        
        StyleWatcher.defaultConfig = config
    }
}

// MARK: - define title property for UIFont.Weight
public extension UIFont.Weight {
    public var title:String{
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
    public var Ultra_Light:String?
    public var Thin:String?
    public var Light:String?
    public var Regular:String?
    public var Medium:String?
    public var Semibold:String?
    public var Bold:String?
    public var Heavy:String?
    public var Black:String?
}



/// App font Singelton
public class AppFont {
    public var Ultra_Light=""
    public var Thin=""
    public var Light=""
    public var Regular=""
    public var Medium=""
    public var Semibold=""
    public var Bold=""
    public var Heavy=""
    public var Black=""
    
    public static let shared = AppFont()
    
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
        for family in familyNames {
            for fontName in fontNames(forFamilyName: family) {
                if fontName==name{
                    return true
                }
            }
        }
        return false
    }
    
    public class func printAllFonts(){
        for family in familyNames {
            print(family)
            for fontName in fontNames(forFamilyName: family) {
                print("\t\(fontName)")
            }
            print("\n")
        }
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
    
    
    fileprivate static func setNavbarFont() {
        
        let apperance = UINavigationBar.appearance()
        var titleAttr = apperance.titleTextAttributes ??  [:]
        titleAttr.updateValue( UIFont(name: AppFont.shared.Semibold, size: 17)!, forKey:  NSAttributedString.Key.font)
        apperance.titleTextAttributes = titleAttr
        
        
        if #available(iOS 9.0, *) {
            let buttonBarAppearance=UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
            var barButtonTitleAttr = convertFromOptionalNSAttributedStringKeyDictionary(buttonBarAppearance.titleTextAttributes(for: .normal)) ?? [:]
            
            barButtonTitleAttr.updateValue(UIFont(name: AppFont.shared.Regular, size: 17)!, forKey: NSAttributedString.Key.font.rawValue)
            
            let convertedAttributes = Dictionary(uniqueKeysWithValues:
                barButtonTitleAttr.lazy.map { (NSAttributedString.Key($0.key), $0.value) }
            )
            buttonBarAppearance.setTitleTextAttributes(convertedAttributes, for: .normal)
        }
        
    }
    
    
    // override system font in IB
    @objc private convenience init(myCoder aDecoder: NSCoder) {
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            let fontAttr = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
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
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))!
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))!
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
            
            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))!
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:)))!
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
            
            //            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            //            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:)))
            //            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
            
            let systemFontWeightMethod = class_getClassMethod(self, #selector(systemFont(ofSize:weight:)))!
            let mySystemFontWeightMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:weight:)))!
            method_exchangeImplementations(systemFontWeightMethod, mySystemFontWeightMethod)
            
            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:)))! // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))!
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
            
            //resolve navigationbar font issues
            setNavbarFont()
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromOptionalNSAttributedStringKeyDictionary(_ input: [NSAttributedString.Key: Any]?) -> [String: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
