//
//  AudioPlayerViewController.swift
//  ComposeMessageModule
//
//  Created by NupurMac on 18/05/18.
//  Copyright © 2018 ShubhamMac. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import MediaPlayer
import EZSwiftExtensions


class AudioPlayerViewController: UIViewController {

    //MARK ::- OUTLETS
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK::- VARIABLES
    var jukebox : Jukebox!
    var item : AZSoundItem?
    var manager : AZSoundManager?
    
    //MARK::- LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        // begin receiving remote events
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        item = AZSoundItem(contentsOf: URL(string :"http://webapi.palmboard.in//Message/FSPSGN/Audio/201805041710017482.mp3"))
        manager = AZSoundManager.shared()
        manager?.preload(item)
    
        manager?.getItemInfo(progressBlock: { (item) in
            if let item = item {
                self.slider.value = Float(item.currentTime / item.duration)
            }
        }, finish: { (item) in
            print("finish playing")
            self.slider.value = 1.0
        })
   }
//
//    func convertTime(_ time: Int) -> String {
//        let minutes: Int = time / 60
//        let seconds: Int = time % 60
//        return String(format: "%02ld:%02ld", Int(minutes), Int(seconds))
//    }
    
    func configureUI ()
    {
        indicator.color = UIColor.white
        slider.setThumbImage(UIImage(named: "sliderThumb"), for: UIControlState())
        slider.minimumTrackTintColor = UIColor.flatGreen
        slider.maximumTrackTintColor = UIColor.white
        
    }
    
    @IBAction func playPauseAction() {
        
        manager?.play()
        
    }
    
    @IBAction func playSliderChanged(_ sender: Any) {
        let item = manager?.currentItem
        let second: Int = Int(Double(slider.value) * /item?.duration)
        manager?.play(atSecond: second)
    }
    
   
    

}





