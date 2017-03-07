//
//  ViewController.swift
//  UIImageViewWithFaceDetection
//
//  Created by 任岐鸣 on 2016/10/9.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var cutSwitch: UISwitch!
    @IBOutlet weak var onlyDetectSwitch: UISwitch!
    
    var faceArr = Array<UIImage>()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @IBAction func doDetect(_ sender: AnyObject) {
        
        imageView.image = UIImage.init(named: "testPic.jpg")
        
        for subView in imageView.subviews {
            subView.removeFromSuperview()
        }
        
        faceArr = imageView.doDetection(type:(cutSwitch.isOn ? .cut : .mark),inset: UIEdgeInsetsMake(5,5,5,5), detectOnly: onlyDetectSwitch.isOn)
        print(faceArr.count)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faceArr.count - 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.imageView?.image = faceArr[indexPath.row]
        
        return cell
    }

}

