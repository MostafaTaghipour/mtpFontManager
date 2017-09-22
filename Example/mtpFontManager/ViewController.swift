//
//  ViewController.swift
//  mtpFontManager
//
//  Created by mostafa.taghipour@ymail.com on 09/22/2017.
//  Copyright (c) 2017 mostafa.taghipour@ymail.com. All rights reserved.
//

import UIKit
import mtpFontManager

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    let watcher = StyleWatcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label.font=UIFont.preferredFont(forTextStyle: .body)
        
        watcher.watchViews(inView: view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

