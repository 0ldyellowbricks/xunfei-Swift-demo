# xunfei-demo
ifly
使用科大讯飞sdk基本流程

添加讯飞自己的库iflyMSC到library
按照讯飞文档
    添加其他需要用的库到library
    确认sdk路径
    swift bridge 添加所有的头文件
    注册讯飞appid 
    
    IFlySpeechRecognizerDelegate protcol 必须实现两个回调：
        onResults(根据你使用的是有界面的还是无界面的方法是不同的)
        onError
    onResults里结果需要json解析 所以还有一个方法必须调用
    
    IFlySpeechSynthesizerDelegate protocol 必须实现两个回调：
        onCompleted
        onError
    语音合成后直接调用startspeaking()就好
