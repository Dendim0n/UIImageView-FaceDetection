//
//  ViewController.swift
//  UIImageViewWithFaceDetection
//
//  Created by 任岐鸣 on 2016/10/9.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @IBAction func doDetect(_ sender: AnyObject) {
        imageView.doDetectionAndResetImage(MarkOrCut: false,inset: UIEdgeInsetsMake(50, 50, 50, 50))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

