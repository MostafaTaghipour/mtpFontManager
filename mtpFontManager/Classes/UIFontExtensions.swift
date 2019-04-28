//
//  SwizzlingSystemFont.swift
//  mtpFontManager
//
//  Created by Mostafa Taghipour on 2/5/19.
//

import Foundation

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




// MARK: - define contains method for UIFont Class
public extension UIFont {
    
    class func contains(fontWith name:String) -> Bool{
        for family in familyNames {
            for fontName in fontNames(forFamilyName: family) {
                if fontName==name{
                    return true
                }
            }
        }
        return false
    }
    
    class func printAllFonts(){
        #if DEBUG
        for family in familyNames {
            print(family)
            for fontName in fontNames(forFamilyName: family) {
                print("\t\(fontName)")
            }
            print("\n")
        }
        #endif
    }
}

// MARK: - Swizzling systemFont with customFont
extension UIFont {
    
    @objc private class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        guard let font = FontManager.shared.currentFont else {
            return  UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
       
        return UIFont(name: font.defaultFont, size: size)!
    }
    
    @objc private class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        guard let font = FontManager.shared.currentFont else {
            return  UIFont.boldSystemFont(ofSize:UIFont.systemFontSize)
        }
        
        return UIFont(name: font.bold ?? font.defaultFont , size: size)!
    }
    
    //    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
    //        return UIFont(name: AppFontName.italic, size: size)!
    //    }
    
    @objc private class func mySystemFont(ofSize size:CGFloat ,weight:UIFont.Weight) -> UIFont {
        
        guard let font = FontManager.shared.currentFont else {
            return  UIFont.systemFont(ofSize:size,weight:weight)
        }
        
        var fontName = font.defaultFont
        
        switch weight {
        case .ultraLight:
            fontName=font.ultraLight ?? font.defaultFont
            break
        case .thin:
            fontName=font.thin ?? font.defaultFont
            break
        case .light:
            fontName=font.light ?? font.defaultFont
            break
        case .regular:
            fontName=font.regular ?? font.defaultFont
            break
        case .medium:
            fontName=font.medium ?? font.defaultFont
            break
        case .semibold:
            fontName=font.semibold ?? font.defaultFont
            break
        case .bold:
            fontName=font.bold ?? font.defaultFont
            break
        case .heavy:
            fontName=font.heavy ?? font.defaultFont
            break
        case .black:
            fontName=font.black ?? font.defaultFont
            break
        default:
            fontName = font.defaultFont
            break
        }
        
        return UIFont(name: fontName, size: size)!
    }
    
    
    fileprivate static func setNavbarFont() {
        
        guard let font = FontManager.shared.currentFont else {
            return
        }
        
        let apperance = UINavigationBar.appearance()
        var titleAttr = apperance.titleTextAttributes ??  [:]
        titleAttr.updateValue( UIFont(name: font.semibold ?? font.defaultFont, size: 17)!, forKey:  NSAttributedString.Key.font)
        apperance.titleTextAttributes = titleAttr
        
        
        if #available(iOS 9.0, *) {
            let buttonBarAppearance=UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
            var barButtonTitleAttr = convertFromOptionalNSAttributedStringKeyDictionary(convertFromOptionalNSAttributedStringKeyDictionary(buttonBarAppearance.titleTextAttributes(for: .normal))) ?? [:]
            
            barButtonTitleAttr.updateValue(UIFont(name: font.regular ?? font.defaultFont, size: 17)!, forKey: NSAttributedString.Key.font.rawValue)
            
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
            if let fontAttribute = fontDescriptor.fontAttributes[fontAttr] as? String ,
                let font = FontManager.shared.currentFont{
                
                var fontName = font.defaultFont
                switch fontAttribute {
                case "CTFontUltraLightUsage":
                    fontName = font.ultraLight ?? font.defaultFont
                case "CTFontThinUsage":
                    fontName = font.thin ?? font.defaultFont
                case "CTFontLightUsage":
                    fontName = font.light ?? font.defaultFont
                case "CTFontRegularUsage":
                    fontName = font.regular ?? font.defaultFont
                case "CTFontMediumUsage":
                    fontName = font.medium ?? font.defaultFont
                case "CTFontDemiUsage":
                    fontName = font.semibold ?? font.defaultFont
                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                    fontName = font.bold ?? font.defaultFont
                case "CTFontHeavyUsage":
                    fontName = font.heavy ?? font.defaultFont
                case "CTFontBlackUsage":
                    fontName = font.black ?? font.defaultFont
                    //                case "CTFontObliqueUsage":
                //                    fontName = AppFontName.italic
                default:
                    fontName = font.defaultFont
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
    
    class  func overrideInitialize() {
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
