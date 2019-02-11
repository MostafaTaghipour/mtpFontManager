//
//  FontManager.swift
//  test
//
//  Created by Mostafa Taghipour on 9/15/17.
//  Copyright © 2017 Mostafa Taghipour. All rights reserved.
//

import UIKit

public class FontManager {
    public static let shared = FontManager()

    private init() {
    }

    private var _currentFont: AppFont?
    public var currentFont: AppFont? {
        set {
            if let oldId = _currentFont?.id, let newId = newValue?.id, newId == oldId {
                return
            }

            _currentFont = newValue
            setup()
        }
        get {
            return _currentFont
        }
    }

    public func reset() {
        guard currentFont != nil else {
            return
        }

        currentFont = nil
    }

    private func setup() {
        UIFont.overrideInitialize()
        applyFontToDynamicTypes()
    }

    /// Apply font to Dynamic Types according https://developer.apple.com/ios/human-interface-guidelines/visual-design/typography/
    private func applyFontToDynamicTypes() {
        guard let font = currentFont else {
            StyleWatcher.config = nil
            return
        }

        var config = StyleConfig()

        // label
        config.label[UIFont.TextStyle.body.rawValue] = font.regular ?? font.defaultFont
        config.label[UIFont.TextStyle.caption1.rawValue] = font.regular ?? font.defaultFont
        config.label[UIFont.TextStyle.caption2.rawValue] = font.regular ?? font.defaultFont
        config.label[UIFont.TextStyle.footnote.rawValue] = font.regular ?? font.defaultFont
        config.label[UIFont.TextStyle.headline.rawValue] = font.semibold ?? font.defaultFont
        config.label[UIFont.TextStyle.subheadline.rawValue] = font.regular ?? font.defaultFont
        if #available(iOS 9.0, *) {
            config.label[UIFont.TextStyle.callout.rawValue] = font.regular ?? font.defaultFont
            config.label[UIFont.TextStyle.title1.rawValue] = font.regular ?? font.defaultFont
            config.label[UIFont.TextStyle.title2.rawValue] = font.regular ?? font.defaultFont
            config.label[UIFont.TextStyle.title3.rawValue] = font.regular ?? font.defaultFont
        }

        //textView
        config.textView[UIFont.TextStyle.body.rawValue] = font.regular ?? font.defaultFont
        config.textView[UIFont.TextStyle.caption1.rawValue] = font.regular ?? font.defaultFont
        config.textView[UIFont.TextStyle.caption2.rawValue] = font.regular ?? font.defaultFont
        config.textView[UIFont.TextStyle.footnote.rawValue] = font.regular ?? font.defaultFont
        config.textView[UIFont.TextStyle.headline.rawValue] = font.semibold ?? font.defaultFont
        config.textView[UIFont.TextStyle.subheadline.rawValue] = font.regular ?? font.defaultFont
        if #available(iOS 9.0, *) {
            config.textView[UIFont.TextStyle.title1.rawValue] = font.regular ?? font.defaultFont
            config.textView[UIFont.TextStyle.title2.rawValue] = font.regular ?? font.defaultFont
            config.textView[UIFont.TextStyle.title3.rawValue] = font.regular ?? font.defaultFont
            config.textView[UIFont.TextStyle.callout.rawValue] = font.regular ?? font.defaultFont
        }

        //textField
        config.textField[UIFont.TextStyle.body.rawValue] = font.regular ?? font.defaultFont
        config.textField[UIFont.TextStyle.caption1.rawValue] = font.regular ?? font.defaultFont
        config.textField[UIFont.TextStyle.caption2.rawValue] = font.regular ?? font.defaultFont
        config.textField[UIFont.TextStyle.footnote.rawValue] = font.regular ?? font.defaultFont
        config.textField[UIFont.TextStyle.headline.rawValue] = font.semibold ?? font.defaultFont
        config.textField[UIFont.TextStyle.subheadline.rawValue] = font.regular ?? font.defaultFont
        if #available(iOS 9.0, *) {
            config.textField[UIFont.TextStyle.title1.rawValue] = font.regular ?? font.defaultFont
            config.textField[UIFont.TextStyle.title2.rawValue] = font.regular ?? font.defaultFont
            config.textField[UIFont.TextStyle.title3.rawValue] = font.regular ?? font.defaultFont
            config.textField[UIFont.TextStyle.callout.rawValue] = font.regular ?? font.defaultFont
        }

        // button
        config.button[UIFont.TextStyle.body.rawValue] = font.regular ?? font.defaultFont
        config.button[UIFont.TextStyle.caption1.rawValue] = font.regular ?? font.defaultFont
        config.button[UIFont.TextStyle.caption2.rawValue] = font.regular ?? font.defaultFont
        config.button[UIFont.TextStyle.footnote.rawValue] = font.regular ?? font.defaultFont
        config.button[UIFont.TextStyle.headline.rawValue] = font.semibold ?? font.defaultFont
        config.button[UIFont.TextStyle.subheadline.rawValue] = font.regular ?? font.defaultFont
        if #available(iOS 9.0, *) {
            config.button[UIFont.TextStyle.title1.rawValue] = font.regular ?? font.defaultFont
            config.button[UIFont.TextStyle.title2.rawValue] = font.regular ?? font.defaultFont
            config.button[UIFont.TextStyle.title3.rawValue] = font.regular ?? font.defaultFont
            config.button[UIFont.TextStyle.callout.rawValue] = font.regular ?? font.defaultFont
        }

        StyleWatcher.config = config

        // NotificationCenter.default.post(name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
}
