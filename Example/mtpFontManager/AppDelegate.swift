//
//  AppDelegate.swift
//  mtpFontManager
//
//  Created by mostafa.taghipour@ymail.com on 09/22/2017.
//  Copyright (c) 2017 mostafa.taghipour@ymail.com. All rights reserved.
//

import FontBlaster
import mtpFontManager
import UIKit


let persistFontKey = "font"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    lazy var exo: AppFont = {
        let font = AppFont(
            id: 1,
            familyName: "Exo",
            defaultFont: "Exo-Regular",
            ultraLight: "Exo-Thin",
            thin: "Exo-ExtraLight",
            light: "Exo-Light",
            regular: "Exo-Regular",
            medium: "Exo-Medium",
            semibold: "Exo-Semibold",
            bold: "Exo-Bold",
            heavy: "Exo-ExtraBold",
            black: "Exo-Black"
        )
        return font
    }()
    
    
    lazy var taviraj: AppFont = {
        let font = AppFont(plist: "taviraj")
        return font
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // load fonts in main bundle
        FontBlaster.blast { fonts in
            print(fonts)
        }
        UIFont.printAllFonts()

        if let savedFont = UserDefaults.standard.string(forKey: persistFontKey) {
            switch savedFont {
            case exo.familyName:
                FontManager.shared.currentFont = exo
                break
            case taviraj.familyName:
                FontManager.shared.currentFont = taviraj
                break
            default:
                break
            }
        }

        return true
    }
}
