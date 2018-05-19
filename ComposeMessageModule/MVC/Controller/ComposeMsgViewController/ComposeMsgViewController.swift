//
//  ViewController.swift
//  ComposeMessageModule
//
//  Created by NupurMac on 15/05/18.
//  Copyright © 2018 ShubhamMac. All rights reserved.
//

import UIKit
import SJSegmentedScrollView

class ComposeMsgViewController : SJSegmentedViewController {
    
    //MARK::- OUTLETS
    var selectedSegment: SJSegmentTab?
    var selectedIndex : Int = 0
    
    //MARK::- LIFE CYCLES
    override func viewDidLoad() {
        onViewDidLoad()
        super.viewDidLoad()
    }
    
    func onViewDidLoad() {
        
        if let storyboard = self.storyboard {
            let headerController = storyboard
                .instantiateViewController(withIdentifier: "HeaderViewController")
            
            let textViewController = storyboard
                .instantiateViewController(withIdentifier: "TextViewController")
            textViewController.title = "Text"
           // textViewController.navigationItem.titleView = setUpImageWithSegmentTab(R.image.ic_text())
            
            let imageViewController = storyboard
                .instantiateViewController(withIdentifier: "ImageViewController")
            imageViewController.title = "Image"
            
            headerViewController = headerController
            segmentControllers = [textViewController,imageViewController]
            setUpSegment()
        }
     }
    
    
}


//MARK::- Segment SetUp
extension ComposeMsgViewController {
    
    func setUpSegment(){
        headerViewHeight = 80
        headerViewOffsetHeight = 0.0
        segmentViewHeight = 56.0
        segmentTitleColor = .lightGray
        selectedSegmentViewHeight = 3.0
        if let font = R.font.ubuntuLight(size: 16.0) {
            segmentTitleFont = font
        }
        selectedSegmentViewColor = UIColor.flatGreen
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        segmentBounces = false
        segmentShadow = SJShadow.init(offset: CGSize(width: 0.0, height: 0.0), color: UIColor.white, radius: 0.0, opacity: 0.0)
        delegate = self
    }
    
    
    func setUpImageWithSegmentTab(_ image : UIImage?) -> UIView {
        let view = UIImageView(frame: CGRect(x: 16.0 , y: segmentViewHeight / 4.0, width: segmentViewHeight / 4.0, height: segmentViewHeight / 4.0))
        
        if let image = image {
         view.image = image
        }
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }
    
}

//MARK::- SJSegmentedScrollView Delegate
extension ComposeMsgViewController : SJSegmentedViewControllerDelegate {
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        
        if selectedSegment != nil {
            selectedSegment?.titleColor(.lightGray)
        }
        
        if segments.count > 0 {
            selectedIndex = index
            selectedSegment = segments[index]
            selectedSegment?.titleColor(UIColor.flatGreen)
        }
    }
}

