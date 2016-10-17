//
//  Global.swift
//  002_Swift
//
//  Created by frayda on 9/22/16.
//  Copyright © 2016 frayda. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HIGH = UIScreen.main.bounds.size.height 

 


// MARK:  科大讯飞集成
/*
添加讯飞自己的库iflyMSC到library
按照讯飞文档
    添加其他需要用的库到library
    确认sdk路径
    swift bridge 添加所有的头文件
    appdelegate里面要注册讯飞appid(不需要再添加头文件了)
    IFlySpeechRecognizerDelegate protcol 必须实现两个回调：
        onResults
        onError
    onResults里结果需要json解析 所以还有一个方法必须调用
    
    IFlySpeechSynthesizerDelegate protocol 必须实现两个回调：
        onCompleted
        onError
    语音合成后直接调用startspeaking()就好
*/
