//
//  SettingViewController.swift
//  mtpFontManager_Example
//
//  Created by Mostafa Taghipour on 2/5/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import mtpFontManager
import UIKit

class SettingViewController: UIViewController {
    @IBOutlet var pickerView: UIPickerView!

    fileprivate var items: [String]!
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        items = ["None", appDelegate.exo.familyName, appDelegate.taviraj.familyName]

        pickerView.dataSource = self
        pickerView.delegate = self

        if let savedValue = UserDefaults.standard.string(forKey: persistFontKey), let index = items.firstIndex(of: savedValue) {
            pickerView.selectRow(index, inComponent: 0, animated: false)
        }
    }

    func reloadAllViewControllers() {
        let storyboard = UIApplication.shared.keyWindow?.rootViewController?.storyboard
        let id = UIApplication.shared.keyWindow?.rootViewController?.value(forKey: "storyboardIdentifier")
        let rootVC = storyboard?.instantiateViewController(withIdentifier: id as! String)
        UIApplication.shared.keyWindow?.rootViewController = rootVC

        if let main = rootVC as? UITabBarController {
            main.selectedIndex = 2
        }
    }
}

extension SettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }

    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = view as? UILabel ?? UILabel()
        label.font = .systemFont(ofSize: 19)
        label.textAlignment = .center
        label.text = items[row]
        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = items[row]

        UserDefaults.standard.set(selectedValue, forKey: persistFontKey)

        FontManager.shared.reset()

        switch selectedValue {
        case appDelegate.exo.familyName:
            FontManager.shared.currentFont = appDelegate.exo
            break
        case appDelegate.taviraj.familyName:
            FontManager.shared.currentFont = appDelegate.taviraj
            break
        default:
            break
        }

        reloadAllViewControllers()
    }
}
