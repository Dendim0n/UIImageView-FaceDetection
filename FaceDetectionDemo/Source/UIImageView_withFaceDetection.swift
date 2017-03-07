//
//  UIImageView_withFaceDetection.swift
//  UIImageViewWithFaceDetection
//
//  Created by 任岐鸣 on 2016/10/9.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit
import CoreImage
import CoreGraphics

extension UIImageView {
    
    enum ProcessType {
        case cut
        case mark
    }
    
    func doDetection(type:ProcessType,inset:UIEdgeInsets?,detectOnly:Bool) -> Array<UIImage> {
        
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector!.features(in: CIImage(image:self.image!)!)
        let ciImageSize = CIImage(image:self.image!)?.extent.size
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -(ciImageSize?.height)!)
        
        var tmpArray = Array<UIImage>()
        
        for face in faces as! [CIFaceFeature] {
            
            var faceViewBounds = face.bounds.applying(transform)
            
            let viewSize = self.bounds.size
            let scale = min(viewSize.width / (ciImageSize?.width)!,
                            viewSize.height / (ciImageSize?.height)!)
            let offsetX = (viewSize.width - (ciImageSize?.width)! * scale) / 2
            let offsetY = (viewSize.height - (ciImageSize?.height)! * scale) / 2
            
            faceViewBounds.origin.x = max(0, faceViewBounds.origin.x - (inset?.left)!)
            faceViewBounds.origin.y = max(0, faceViewBounds.origin.y - (inset?.top)!)
            
            faceViewBounds.size.height = min(faceViewBounds.origin.y + faceViewBounds.size.height + (inset?.bottom)! + (inset?.top)!,(ciImageSize?.height)!)
            faceViewBounds.size.height = faceViewBounds.size.height - faceViewBounds.origin.y
            
            faceViewBounds.size.width = min(faceViewBounds.origin.x + faceViewBounds.size.width + (inset?.left)! + (inset?.right)!,(ciImageSize?.width)!)
            faceViewBounds.size.width = faceViewBounds.size.width - faceViewBounds.origin.x
            
            let imageRef = self.image!.cgImage!.cropping(to: faceViewBounds)
            let cutImage = UIImage.init(cgImage: imageRef!)
            tmpArray.append(cutImage)
            
            if type == .mark {
                faceViewBounds = faceViewBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
                faceViewBounds.origin.x += offsetX
                faceViewBounds.origin.y += offsetY
                
                let faceBox = UIView(frame: faceViewBounds)
                
                faceBox.layer.borderWidth = 3
                faceBox.layer.borderColor = UIColor.red.cgColor
                faceBox.backgroundColor = UIColor.clear
                
                if detectOnly {
                    self.addSubview(faceBox)
                }
            }
            
        }
        if type == .cut {
            tmpArray.sort { (img1, img2) -> Bool in
                img1.size.height * img1.size.width > img2.size.height * img2.size.width
            }
            if detectOnly {
                self.image = tmpArray[0]
            }
        }
        return tmpArray
    }
    
    
}
