//
//  CommandEditView.swift
//  002_Swift
//
//  Created by frayda on 10/11/16.
//  Copyright © 2016 frayda. All rights reserved.
//

import UIKit

class CommandEditView: UIView {
    var imageView : UIImageView!
    var cancelBtn : UIButton!
    var okBtn : UIButton!
    var editImage : UIImageView!
    var commandLineView : UITextView!
    override init(frame : CGRect){
        super.init(frame : frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        imageView = UIImageView()
        self.addSubview(imageView)
        imageView.image = UIImage.init(named: "command_info")
        cancelBtn = UIButton()
        self.addSubview(cancelBtn)
        cancelBtn.setImage(UIImage.init(named: "command_cancel"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        okBtn = UIButton()
        self.addSubview(okBtn)
        okBtn.setImage(UIImage.init(named: "command_ok"), for: .normal)
        editImage = UIImageView()
        self.addSubview(editImage)
        commandLineView = UITextView()
        editImage.image = UIImage.init(named: "command_edit")
        self.addSubview(commandLineView)
        commandLineView.backgroundColor = .clear
        commandLineView.textColor = UIColor(red:0.58, green:0.86, blue:0.80, alpha:1.00)
        commandLineView.layer.borderWidth = 1
        commandLineView.font = UIFont.systemFont(ofSize: 15)
        commandLineView.layer.borderColor = UIColor(red:0.58, green:0.86, blue:0.80, alpha:1.00).cgColor
        updateFrame()
    }
    func updateFrame(){
        commandLineView.snp.makeConstraints { (make)->Void in
            make.centerX.equalTo(self)
            make.width.equalTo(SCREEN_WIDTH-120)
            make.height.equalTo(35)
            make.bottom.equalTo(okBtn.snp.top).offset(-45)
        }
        editImage.snp.makeConstraints { (make)->Void in
            make.right.equalTo(commandLineView.snp.right).inset(5)
            make.centerY.equalTo(commandLineView)
            make.width.height.equalTo(20)
        }
        imageView.snp.makeConstraints { (make)->Void in
            make.height.equalTo(40)
            make.width.equalTo(50)
            make.centerX.equalTo(self).offset(9)
            make.bottom.equalTo(self.snp.centerY).offset(-80)
        }
        cancelBtn.snp.makeConstraints { (make)->Void in
            make.right.equalTo(self.snp.centerX).offset(-45)
            make.width.height.equalTo(50)
            make.bottom.equalTo(self.snp.centerY).offset(60)
        }
        okBtn.snp.makeConstraints { (make)->Void in
            make.left.equalTo(self.snp.centerX).offset(45)
            make.top.height.width.equalTo(cancelBtn)
        }
    }
    func cancelBtnClicked(){
        self.isHidden = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
