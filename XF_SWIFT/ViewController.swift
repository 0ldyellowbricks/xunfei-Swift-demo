//
//  ViewController.swift
//  XF_SWIFT
//
//  Created by frayda on 10/17/16.
//  Copyright © 2016 frayda. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController,IFlySpeechRecognizerDelegate,IFlySpeechSynthesizerDelegate,AVAudioRecorderDelegate,UITextViewDelegate {
    var _iflyRecognizerView : IFlySpeechRecognizer!
    var _iFlySpeechSynthesizer : IFlySpeechSynthesizer!
    var speechResult : NSString?
    var finalCommand : NSString!
    var micBgview : MicSoundView!
    var commandView :CommandEditView!
    var timer : Timer?
    var recorder : AVAudioRecorder?
    override func viewDidLoad() {
        super.viewDidLoad()
        speechResult = ""
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .white
        initPage()
        intRecognizer()
        setRecorder()
    }
    override func viewWillAppear(_ animated: Bool) {
        initSynthesizer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        _iFlySpeechSynthesizer.stopSpeaking();
        _iFlySpeechSynthesizer.delegate = nil
        super.viewWillDisappear(animated)
    }
    func initSynthesizer(){
        let instance = TTSConfig.sharedInstance()
        if instance == nil {
            return
        }
        if _iFlySpeechSynthesizer == nil {
            _iFlySpeechSynthesizer = IFlySpeechSynthesizer.sharedInstance()
        }
        _iFlySpeechSynthesizer.delegate = self
        _iFlySpeechSynthesizer.setParameter(instance?.speed, forKey: IFlySpeechConstant.speed())
        _iFlySpeechSynthesizer.setParameter(instance?.volume, forKey: IFlySpeechConstant.volume())
        _iFlySpeechSynthesizer.setParameter(instance?.pitch, forKey: IFlySpeechConstant.pitch())
        _iFlySpeechSynthesizer.setParameter(instance?.sampleRate, forKey: IFlySpeechConstant.sample_RATE())
        _iFlySpeechSynthesizer.setParameter(instance?.vcnName, forKey: IFlySpeechConstant.voice_NAME())
        _iFlySpeechSynthesizer.setParameter("unicode", forKey: IFlySpeechConstant.text_ENCODING())
    }
    func initPage(){
        let voiceBtn = UIButton()
        view.addSubview(voiceBtn)
        voiceBtn.snp.makeConstraints { (make)->Void in
            make.centerX.equalTo(view)
            make.width.height.equalTo(100)
            make.bottom.equalTo(view).inset(100)
        }
        voiceBtn.setImage(UIImage.init(named: "voice_selected"), for: .normal)
        voiceBtn.addTarget(self, action: #selector(voiceBtnDown), for: .touchDown)
        voiceBtn.addTarget(self, action: #selector(voiceBtnUp), for: .touchUpInside)
        voiceBtn.addTarget(self, action: #selector(voiceBtnDragUp), for: .touchDragExit)
        //MARK: 自动手动控制按钮和方向键按钮界面
        //MARK: 麦克风音量动画界面
        micBgview = MicSoundView()
        self.view.addSubview(micBgview)
        micBgview.snp.makeConstraints { (make)->Void in
            make.left.right.top.bottom.equalTo(self.view)
        }
        micBgview.isHidden = true
        
    }
    func intRecognizer(){
        _iflyRecognizerView = IFlySpeechRecognizer.sharedInstance()
        _iflyRecognizerView.delegate = self
        _iflyRecognizerView.setParameter("", forKey: IFlySpeechConstant.params())
    }
    func setRecorder(){
        let url:NSURL = NSURL.fileURL(withPath: "/dev/null") as NSURL
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVLinearPCMBitDepthKey: 16,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        do {
            recorder = try AVAudioRecorder(url: url as URL, settings: settings)
            recorder?.prepareToRecord()
            recorder?.isMeteringEnabled = true
            recorder?.delegate = self
        } catch {
            finishRecording(success: false)
        }
    }
    
    
    func voiceBtnDown(){
        if (speechResult?.length)!>0 {
            speechResult = ""
        }
        _iflyRecognizerView.startListening()
        recorder?.record()
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(detectionVoice), userInfo: nil, repeats: true)
    }
    func voiceBtnUp(){
        micBgview.isHidden = true
        _iflyRecognizerView.stopListening()
        recorder?.deleteRecording()
        recorder?.stop()
        timer?.invalidate()
    }
    func voiceBtnDragUp(){
        micBgview.isHidden = true
        _iflyRecognizerView.stopListening()
        recorder?.deleteRecording()
        recorder?.stop()
        timer?.invalidate()
    }
    
    
    func finishRecording(success: Bool) {
        recorder?.stop()
    }
    func detectionVoice(){
        micBgview.isHidden = false
        recorder?.updateMeters()
        let ALPHA = 0.05
        let lowPassResults : Double  = pow(10, (ALPHA * Double((recorder?.averagePower(forChannel: 0))!)))
        micBgview.changeVolumeImage(lowPassResults: lowPassResults)
    }
    
    func onResults(_ results: [Any]!, isLast: Bool) {
        let resultString: NSMutableString = ""
        if results != nil {
            let dict = results[0] as! NSDictionary
            for (key,_) in dict {
                resultString.append("\(key)")
            }
            let resultFromJson = ISRDataHelper.string(fromJson: resultString as String!)
            speechResult = "\(speechResult! as NSString)\(resultFromJson!)" as NSString?
            if isLast {
                finalCommand = speechResult! as NSString
                finalCommand = finalCommand.substring(to: finalCommand.length-1) as NSString
                commandView = CommandEditView()
                self.view.addSubview(commandView)
                commandView.snp.makeConstraints({ (make)->Void in
                    make.left.right.top.bottom.equalTo(self.view)
                })
                commandView.commandLineView.text = (finalCommand as NSString) as String
                commandView.commandLineView.delegate = self
                commandView.okBtn.addTarget(self, action: #selector(commandViewOkBtnClicked), for: .touchUpInside)
            }
        }
    }
    func onError(_ errorCode: IFlySpeechError!) {
    }
    func onCompleted(_ error: IFlySpeechError!) {
    }
    func commandViewOkBtnClicked(){
        finalCommand = commandView.commandLineView.text as NSString!
        commandView.isHidden = true
        commandSoundPlay()
    }
    func commandSoundPlay(){
        let commandPlayStr = "正在执行命令\(finalCommand as NSString)"
        _iFlySpeechSynthesizer.startSpeaking(commandPlayStr as String!);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

