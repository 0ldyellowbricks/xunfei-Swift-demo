//
//  MicSoundView.swift
//  002_Swift
//
//  Created by frayda on 10/10/16.
//  Copyright © 2016 frayda. All rights reserved.
//

import UIKit
class MicSoundView: UIView {
    var imageView : UIImageView!
    override init(frame : CGRect){
        super.init(frame : frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        imageView = UIImageView()
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make)->Void in
            make.left.equalTo((SCREEN_WIDTH-100)/2)
            make.top.equalTo(200)
            make.width.equalTo(100)
            make.height.equalTo(130)
        }
    }
    func changeVolumeImage(lowPassResults:Double){
        if lowPassResults <= 0.06 {
            imageView.image = UIImage.init(named: "record_animate_01")
        }else if lowPassResults <= 0.13 {
            imageView.image = UIImage.init(named: "record_animate_02")
        }else if lowPassResults <= 0.20 {
            imageView.image = UIImage.init(named: "record_animate_03")
        }else if lowPassResults <= 0.27 {
            imageView.image = UIImage.init(named: "record_animate_04")
        }else if lowPassResults <= 0.34 {
            imageView.image = UIImage.init(named: "record_animate_05")
        }else if lowPassResults <= 0.41 {
            imageView.image = UIImage.init(named: "record_animate_06")
        }else if lowPassResults <= 0.48 {
            imageView.image = UIImage.init(named: "record_animate_07")
        }else if lowPassResults <= 0.55 {
            imageView.image = UIImage.init(named: "record_animate_08")
        }else if lowPassResults <= 0.62 {
            imageView.image = UIImage.init(named: "record_animate_09")
        }else if lowPassResults <= 0.69 {
            imageView.image = UIImage.init(named: "record_animate_10")
        }else if lowPassResults <= 0.76 {
            imageView.image = UIImage.init(named: "record_animate_11")
        }else if lowPassResults <= 0.83 {
            imageView.image = UIImage.init(named: "record_animate_12")
        }else if lowPassResults <= 0.9 {
            imageView.image = UIImage.init(named: "record_animate_13")
        }else {
            imageView.image = UIImage.init(named: "record_animate_14")
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
