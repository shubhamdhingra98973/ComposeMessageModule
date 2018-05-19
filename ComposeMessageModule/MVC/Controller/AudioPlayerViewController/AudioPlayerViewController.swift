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
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK::- VARIABLES
    var item : AZSoundItem?
    var manager : AZSoundManager?
    var audioUrl : String? = "http://webapi.palmboard.in//Message/FSPSGN/Audio/201805041710017482.mp3"
    
    //MARK::- LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad()
       
   }
    
    func onViewDidLoad() {
        configureUI()
        configureSoundManager()
     
    }
    
    //ConfigureUI
    func configureUI (){
        
        indicator.color = UIColor.white
        slider.setThumbImage(R.image.playTimeline(), for: UIControlState())
        slider.minimumTrackTintColor = UIColor.flatGreen
        slider.maximumTrackTintColor = UIColor.white

    }
    
   
    
    
    //MARK::- BUTTON ACTIONS
    @IBAction func playPauseAction() {
    let status = getManagerStatus()
        switch status {
        case 0 , 1:
        manager?.play()
        updateAudioStateUI(status)
        btnPlayPause.setImage(R.image.pause(), for: .normal)
            
        case 2:
        btnPlayPause.setImage(R.image.play(), for: .normal)
        manager?.pause()
            
            
        case 3:
         btnPlayPause.setImage(R.image.pause(), for: .normal)
         manager?.play()
            
        case 4:
        self.slider.value = 0.0
        btnPlayPause.setImage(R.image.pause(), for: .normal)
        manager?.restart()
            
        default:
            break
        }
    }
    
    @IBAction func playSliderChanged(_ sender: Any) {
        let item = manager?.currentItem
        let second: Int = Int(Double(slider.value) * /item?.duration)
        manager?.play(atSecond: second)
    }

}


//MARK::- AZSoundManager
extension AudioPlayerViewController {
    
    func getManagerStatus() -> Int {
        return /self.manager?.status.rawValue
    }
    
    //Configure SoundManager
    func configureSoundManager() {
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        item = AZSoundItem(contentsOf: URL(string : audioUrl!))
        manager = AZSoundManager.shared()
        manager?.preload(item)
        manager?.getItemInfo(progressBlock: { (item) in
            if let item = item {
                self.slider.value = Float(item.currentTime / item.duration)
                self.updateAudioStateUI(self.getManagerStatus())
            }
        }, finish: { (item) in
            print("finish playing")
            print(/self.manager?.status.rawValue)
            self.updateAudioStateUI(self.getManagerStatus())
        })
    }
    
    func updateAudioStateUI(_ status : Int) {
        
        switch  status {
            
        //NotStarted
        case 0:
        print("Not Started")
        btnPlayPause.setImage(R.image.play(), for: .normal)
            
        //Preparing
        case 1:
        print("Preparing")
        btnPlayPause.setImage(R.image.play(), for: .normal)
        
        //Playing
        case 2:
        print("Playing")
        btnPlayPause.setImage(R.image.pause(), for: .normal)
            
        //Paused
        case 3:
        print("Paused")
        btnPlayPause.setImage(R.image.play(), for: .normal)
        
        //finished
        case 4:
        print("finished")
        btnPlayPause.setImage(R.image.play(), for: .normal)
        self.slider.value = 1.0
        
        default :
        self.slider.value = 0.0
        btnPlayPause.setImage(R.image.play(), for: .normal)
        self.manager?.stop()
        break
            
        }
    }
}





