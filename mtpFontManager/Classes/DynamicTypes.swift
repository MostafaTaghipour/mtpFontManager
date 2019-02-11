//
//  FontManager+DynamicTypes.swift
//  test
//
//  Created by Mostafa Taghipour on 9/16/17.
//  Copyright © 2017 Mostafa Taghipour. All rights reserved.
//

import UIKit



///// DynamicTypeManager is a lot to type... 'DynamicTypeManager' is shorter.
//typealias DynamicTypeManager = DynamicTypeManager

/**
 `DynamicTypeManager` is a singleton that watches for the `UIContentSizeCategoryDidChangeNotification` notification and then updates all views to the new size accordingly. By default, Dynamic Type only works with the system font. DynamicTypeManager allows any font installed to be substituted.
 */
class DynamicTypeManager {
    
    fileprivate struct Values {
        static let fontKeyPathUILabel =   "font"
        static let fontKeyPathUIButton =  "titleLabel.font"
        static let fontKeyPathTextField = "font"
        static let fontKeyPathTextView =  "font"
    }
    
    /**
     The singleton instance of `DynamicTypeManager`.
     */
    static let shared = DynamicTypeManager()
    
    /// Storage and lookup for the views `DynamicTypeManager` is tracking.
    private var elementToTypeTable = NSMapTable<AnyObject, AnyObject>.weakToStrongObjects()
    
    private init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(DynamicTypeManager.contentSizeCategoryDidChange(notification:)),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)
    }
    
     deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /**
     Start watching a `UILabel`. It's font will be defined by `fontName` and its size will be determined by the `textStyle`.
     
     - Parameter label: The `UILabel` to watch.
     - Parameter textStyle: The equivalent text style to size against.
     - Parameter fontName: The name of the custom font to use.
     */
    func watchLabel(label: UILabel, textStyle: String, fontName: String) {
        watchElement(view: label, fontKeyPath: Values.fontKeyPathUILabel, textStyle: textStyle, fontName: fontName)
    }
    
    /**
     Start watching a `UIButton`. It's font will be defined by `fontName` and its size will be determined by the `textStyle`.
     
     - Parameter button: The `UIButton` to watch.
     - Parameter textStyle: The equivalent text style to size against.
     - Parameter fontName: The name of the custom font to use.
     */
    func watchButton(button: UIButton, textStyle: String, fontName: String) {
        watchElement(view: button, fontKeyPath: Values.fontKeyPathUIButton, textStyle: textStyle, fontName: fontName)
    }
    
    /**
     Start watching a `UITextField`. It's font will be defined by `fontName` and its size will be determined by the `textStyle`.
     
     - Parameter textField: The `UITextField` to watch.
     - Parameter textStyle: The equivalent text style to size against.
     - Parameter fontName: The name of the custom font to use.
     */
    func watchTextField(textField: UITextField, textStyle: String, fontName: String) {
        watchElement(view: textField, fontKeyPath: Values.fontKeyPathTextField, textStyle: textStyle, fontName: fontName)
    }
    
    /**
     Start watching a `UITextView`. It's font will be defined by `fontName` and its size will be determined by the `textStyle`.
     
     - Parameter textView: The `UITextView` to watch.
     - Parameter textStyle: The equivalent text style to size against.
     - Parameter fontName: The name of the custom font to use.
     */
    func watchTextView(textView: UITextView, textStyle: String, fontName: String) {
        watchElement(view: textView, fontKeyPath: Values.fontKeyPathTextView, textStyle: textStyle, fontName: fontName)
    }
    
    /**
     Start watching any view. It's font will be defined by `fontName` and its size will be determined by the `textStyle`.
     
     - Parameter view: The `UIView` to watch.
     - Parameter fontKeyPath: The Key Value Coding path to the appropriate font attribute.
     - Parameter textStyle: The equivalent text style to size against.
     - Parameter fontName: The name of the custom font to use.
     */
    fileprivate func watchElement(view: UIView, fontKeyPath: String, textStyle: String, fontName: String) {
        view.setValue(fontForTextStyle(style: textStyle, fontName: fontName), forKeyPath: fontKeyPath)
        let typeElement = DynamicTypeElement(keyPath: fontKeyPath, textStyle: textStyle, fontName: fontName)
        elementToTypeTable.setObject(typeElement, forKey: view)
    }
    
    /**
     Looks up the `UIFont` with the `fontName` and the size defined by the `style`. Firsts checks the `DynamicFontRegistry` for a custom size, then the `preferredFontForTextStyle` for fonts.
     
     - Parameter style: The equivalent system font style to apply to the font.
     - Parameter fontName: The name of the non-system font.
     
     - Returns: The font with the `fontName` and size defined by the preferred font with `style`. If the `fontName` is not a valid font on the device, the system font for the `style` is used.
     */
    fileprivate func fontForTextStyle(style: String, fontName: String) -> UIFont {
        if let customSize = DynamicFontRegistry.registry.scaledFontSizeForStyle(textStyle: style) {
            return UIFont(name: fontName, size: customSize)!
        }
        
        let systemFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle(rawValue: style))
        guard let customFont = UIFont(name: fontName, size: systemFont.pointSize) else {
            return systemFont
        }
        return customFont
    }
    
    /**
     Catches the notification for `UIContentSizeCategoryDidChangeNotification`. Updates all of the views stored in the internal storage.
     */
    @objc fileprivate func contentSizeCategoryDidChange(notification: NSNotification) {
        let enumerator = elementToTypeTable.keyEnumerator()
        while let view = enumerator.nextObject() as? UIView {
            if let element = elementToTypeTable.object(forKey: view) as? DynamicTypeElement {
                let font = fontForTextStyle(style: element.textStyle, fontName: element.fontName)
                view.setValue(font, forKeyPath: element.keyPath)
            }
        }
    }
}

/**
 A wrapper around all of the attributes needed when the content size updates. Not a Struct because those can't be stored in `NSMapTable`.
 */
fileprivate class DynamicTypeElement {
    let keyPath: String
    let textStyle: String
    let fontName: String
    
    init(keyPath: String, textStyle: String, fontName: String) {
        self.keyPath = keyPath
        self.textStyle = textStyle
        self.fontName = fontName
    }
}


/// Keys of the dictionary are the text styles, values are the names of the custom font.
/// Example: dictionary[UIFontTextStyleHeadline] = "Verdana"
public typealias StyleConfigDictionary = [String: String?] // textStyle: customFontName

/// Container for all of the views that are supported by the DynamicTypeManager.
public struct StyleConfig {
    /// Style dictionary for UIButtons
    public var button = StyleConfigDictionary()
    
    /// Style dictionary for UILabels
    public var label = StyleConfigDictionary()
    
    /// Style dictionary for UITextFields
    public var textField = StyleConfigDictionary()
    
    /// Style dictionary for UITextViews
    public var textView = StyleConfigDictionary()
    
    /// Default initializer
    public init() {}
}



/**
 `ScaledFontDescriptor` describes how to scale a font with a specific text style.
 */
fileprivate struct ScaledFontDescriptor {
    let originalTextStyle: String
    let scaleAmount: Float
}

/**
 `DynamicFontRegistry` contains a list of custom font sizes that can be used with Dynamic Type. You can register a custom style that is a scaled version of an existing font style defined by iOS. When the custom font is retrieved it is scaled appropriately along with all the other fonts.
 */
fileprivate class DynamicFontRegistry {
    
    /**
     The singleton instance of `DynamicFontRegistry`.
     */
    public static let registry = DynamicFontRegistry()
    
    private init() {}
    
    private var styleDictionary = [String: ScaledFontDescriptor]()
    
    /**
     Registers a custom text style.
     
     - Parameter textStyle: The unique identifier for to be registered.
     - Parameter scaledFrom: The built-in text style on which this is based.
     - Parameter byFactor: The multiplier to scale the custom font by.
     */
    public func addTextStyle(textStyle: String, scaledFrom originalTextStyle: String, byFactor scaleAmount: Float) {
        styleDictionary[textStyle] = ScaledFontDescriptor(originalTextStyle: originalTextStyle, scaleAmount: scaleAmount)
    }
    
    /**
     Retrieves a registered font size and scales it. If the text style was not registered, `nil` is returned.
     
     - Parameter textStyle: The identifier to look up.
     */
    func scaledFontSizeForStyle(textStyle: String) -> CGFloat? {
        if let descriptor = styleDictionary[textStyle] {
            let baseFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle(rawValue: descriptor.originalTextStyle))
            return baseFont.pointSize * CGFloat(descriptor.scaleAmount)
        }
        return nil
    }
}

// These extensions are shortcuts to get the textStyle that was set for Dynamic Type

fileprivate extension UILabel {
    var textStyle: String? {
       return font.fontDescriptor.fontAttributes[Constants.dynamicTextAttribute] as? String
    }
}

fileprivate extension UIButton {
    var textStyle: String? {
        let key = Constants.dynamicTextAttribute
        return titleLabel?.font.fontDescriptor.fontAttributes[key] as? String
    }
}

fileprivate extension UITextField {
    var textStyle: String? {
        return font?.fontDescriptor.fontAttributes[Constants.dynamicTextAttribute] as? String
    }
}

fileprivate extension UITextView {
    var textStyle: String? {
        return font?.fontDescriptor.fontAttributes[Constants.dynamicTextAttribute] as? String
    }
}


/// Allows subscripting on an `NSMapTable`.
fileprivate class CustomNSMapTable: NSMapTable<AnyObject, AnyObject> {
    subscript(key: AnyObject) -> AnyObject? {
        get {
            return object(forKey: key)
        }
        
        set {
            if newValue != nil {
                setObject(newValue, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}


/**
 `StyleWatcher` will watch a view's subviews and apply the appropriate textStyle
 to it via the `DynamicTypeManager`.
 */
public struct StyleWatcher {
    /// An empty config object that is used if one is not passed into the watch methods.
    public static var config : StyleConfig? = StyleConfig()
    
    /// Default initializer
    public init() {}
    
    /**
     Recursively enumerates over all of the subviews in `container`. If any of
     the subviews have an appropriate dynamic type textstyle applied, they will
     be added to the `DynamicTypeManager`.
     
     - Parameter inView: The container view to enumerate over.
     - Parameter withConfig: A `StyleConfig` to use on any appropriate views.
     */
    public func watchViews(inView container: UIView, withConfig config: StyleConfig? = config) {
        for view in container.subviews {
            switch view {
            case view as UIButton: watchButton(button: view as! UIButton, withConfig: config)
            case view as UILabel: watchLabel(label: view as! UILabel, withConfig: config)
            case view as UITextView: watchTextView(textView: view as! UITextView, withConfig: config)
            case view as UITextField: watchTextField(textField: view as! UITextField, withConfig: config)
            default:
                watchViews(inView: view, withConfig: config)
            }
        }
    }
    
    /**
     If `button` has an appropriate textStyle in the `config`, add it to the `DynamicTypeManager`
     
     - Parameter button: The button to watch.
     - Parameter withConfig: A `StyleConfig` to use if the button's style stored within.
     */
    public func watchButton(button: UIButton, withConfig config: StyleConfig? = config) {
        guard let textStyle = button.textStyle,
            let customFontName = config?.button[textStyle],
            let fontName = customFontName else { return }
        DynamicTypeManager.shared.watchButton(button: button, textStyle: textStyle, fontName: fontName)
    }
    
    /**
     If `label` has an appropriate textStyle in the `config`, add it to the `DynamicTypeManager`
     
     - Parameter label: The button to watch.
     - Parameter withConfig: A `StyleConfig` to use if the button's style stored within.
     */
    public func watchLabel(label: UILabel, withConfig config: StyleConfig? = config) {
        guard let textStyle = label.textStyle,
            let customFontName = config?.label[textStyle],
            let fontName = customFontName else { return }
        DynamicTypeManager.shared.watchLabel(label: label, textStyle: textStyle, fontName: fontName)
    }
    
    /**
     If `textField` has an appropriate textStyle in the `config`, add it to the `DynamicTypeManager`
     
     - Parameter textField: The text field to watch.
     - Parameter withConfig: A `StyleConfig` to use if the button's style stored within.
     */
    public func watchTextField(textField: UITextField, withConfig config: StyleConfig? = config) {
        guard let textStyle = textField.textStyle,
            let customFontName = config?.textField[textStyle],
            let fontName = customFontName else { return }
        DynamicTypeManager.shared.watchTextField(textField: textField, textStyle: textStyle, fontName: fontName)
    }
    
    /**
     If `textView` has an appropriate textStyle in the `config`, add it to the `DynamicTypeManager`
     
     - Parameter textView: The text view to watch.
     - Parameter withConfig: A `StyleConfig` to use if the button's style stored within.
     */
    public func watchTextView(textView: UITextView, withConfig config: StyleConfig? = config) {
        guard let textStyle = textView.textStyle,
            let customFontName = config?.textView[textStyle],
            let fontName = customFontName else { return }
        DynamicTypeManager.shared.watchTextView(textView: textView, textStyle: textStyle, fontName: fontName)
    }
}


