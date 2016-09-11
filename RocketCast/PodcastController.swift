//
//  ViewController.swift
//  RocketCast
//
//  Created by Odin on 2016-08-27.
//  Copyright © 2016 UBCLaunchPad. All rights reserved.
//

import UIKit

class PodcastController: UIViewController {
    
    var mainView: PodcastView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let url = "http://startalkradio.net/rss"
   
        let data = NSData(contentsOfURL:      NSURL(string: url)!)
//        let xmlfilePath = NSBundle.mainBundle().URLForResource("testPodcastXML", withExtension: "xml")!
//        let stringPath = xmlfilePath.absoluteString
//        let data = NSData(contentsOfURL: NSURL(string: stringPath)!)
        ModelBridge.sharedInstance.downloadPodcastXML(data!) { (downloadedPodcast) in
            
        }
    }
    
    private func setupView() {
        let viewSize = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        mainView = PodcastView.instancefromNib(viewSize)
        view.addSubview(mainView!)
        self.mainView?.viewDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
  
    

}
extension PodcastController:PodcastViewDelegate {
    
    func segueToEpisode() {
        performSegueWithIdentifier(Segues.segueFromPodcastToEpisode, sender: self)
    }
    
    
}