//
//  ViewController.swift
//  ChatBubbleTest
//
//  Created by daiki ichikawa on 2017/10/23.
//  Copyright © 2017年 Daiki Ichikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let segueId = "segueToChatLogController"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueId {
            
        }
    }
    
}
