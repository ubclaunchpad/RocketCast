//
//  DownloadTests.swift
//  RocketCast
//
//  Created by Milton Leung on 2016-09-10.
//  Copyright © 2016 UBCLaunchPad. All rights reserved.
//

import XCTest
import AVFoundation

@testable import RocketCast

class DownloadTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDownloadPodcastXML() {
        // Test real podcasts
        var done = false
        let url = "http://billburr.libsyn.com/rss"
        let fileMgr = FileManager.default
        
        ModelBridge.sharedInstance.downloadPodcastXML(url) { (downloadedPodcast) in
            done = true
            
            XCTAssertNotNil(downloadedPodcast)
            
            let path = NSHomeDirectory() + downloadedPodcast!
            if let data = fileMgr.contents(atPath: path) {
                let xmlString = String(data:data, encoding: String.Encoding.utf8)!
                Log.info(xmlString)
                XCTAssertTrue(xmlString.contains("xml") && xmlString.contains("xml"))
            }
        }
        waitUntil(6) {done}
        done = false
        let url2 = "http://www.npr.org/rss/podcast.php?id=510298"
        
        ModelBridge.sharedInstance.downloadPodcastXML(url2) { (downloadedPodcast) in
            done = true
            
            XCTAssertNotNil(downloadedPodcast)
            
            let path = NSHomeDirectory() + downloadedPodcast!
            
            if let data = fileMgr.contents(atPath: path) {
                let xmlString = String(data:data, encoding: String.Encoding.utf8)!
                Log.info(xmlString)
                XCTAssertTrue(xmlString.contains("xml") && xmlString.contains("xml"))
            }
        }
        
        waitUntil(6) {done}
    }
    
    func testDownloadRandomString() {
        // Testing a random string
        var done = false
        let url = "fawefwefaw"
        
        ModelBridge.sharedInstance.downloadPodcastXML(url) { (downloadedPodcast) in
            done = true
            XCTAssertNil(downloadedPodcast)
        }
        
        waitUntil(6) {done}
    }
    
    func testDownloadNonPodcastLinkXML() {
        // Testing a random non podcast link
        var done = false
        let url = "http://www.google.ca/"
        
        ModelBridge.sharedInstance.downloadPodcastXML(url) { (downloadedPodcast) in
            done = true
            XCTAssertNil(downloadedPodcast)
        }
        
        waitUntil(6) {done}
    }
    
    func testDownloadPodcastAudio() {
        // Test real audio
        var done = false
        
        var url = "http://www.scientificamerican.com/podcast/podcast.mp3?fileId=14824345-7D79-454F-9A8F30B98EE219F3"
        let fileMgr = FileManager.default
        
        ModelBridge.sharedInstance.downloadAudio(url, result: { (downloadedPodcast) in
            done = true
            
            XCTAssertNotNil(downloadedPodcast)
            
            let path = NSHomeDirectory() + downloadedPodcast!
            
            if let data = fileMgr.contents(atPath: path) {
                XCTAssertEqual(data.count, 2002733)
            }
        })
        
        waitUntil(6) {done}
        done = false
        
        url = "http://www.scientificamerican.com/podcast/podcast.mp3?fileId=C13A2C3C-F951-4C81-BF7B323A1D0C5A28"
        
        ModelBridge.sharedInstance.downloadAudio(url, result: { (downloadedPodcast) in
            done = true
            
            XCTAssertNotNil(downloadedPodcast)
            
            let path = NSHomeDirectory() + downloadedPodcast!
            
            if let data = fileMgr.contents(atPath: path) {
                XCTAssertEqual(data.count, 1623175)
            }
        })
        
        waitUntil(6) {done}
    }
    
    func testDownloadRandomStringAudio() {
        // Testing a random string
        var done = false
        let url = "fawefwefaw"
        
        ModelBridge.sharedInstance.downloadAudio(url, result: { (downloadedPodcast) in
            done = true
            XCTAssertNil(downloadedPodcast)
        })
        
        waitUntil(6) {done}
    }
    
    func testDownloadNonAudio() {
        // Testing a random non podcast link
        var done = false
        let url = "http://www.google.ca/"
        
        ModelBridge.sharedInstance.downloadAudio(url, result: { (downloadedPodcast) in
            done = true
            XCTAssertNil(downloadedPodcast)
        })
        
        waitUntil(6) {done}
    }
    
    func testDownloadImageNil() {
        var done = false
        let brokenUrl = "blablac"
        ModelBridge.sharedInstance.downloadImage(brokenUrl) { (downloadedImage) in
            done = true
            let imageFromPath = UIImage(contentsOfFile: downloadedImage)
            XCTAssertNil(imageFromPath)
        }
        waitUntil(6) {done}
    }
    
    func testDownloadImage() {
        var done = false
        let urlTestImage = "http://www.apple.com/euro/ios/ios8/a/generic/images/og.png"
        ModelBridge.sharedInstance.downloadImage(urlTestImage) { (downloadedImage) in
            done = true
            let imageFromPath = UIImage(contentsOfFile: downloadedImage)
            XCTAssertEqual(1200,(imageFromPath?.size.width))
            XCTAssertEqual(630,(imageFromPath?.size.height))
        }
        waitUntil(6) {done}
    }
    
    fileprivate func waitUntil(_ timeout: TimeInterval, predicate:((Void) -> Bool)) {
        let timeoutTime = Date(timeIntervalSinceNow: timeout).timeIntervalSinceReferenceDate
        
        while (!predicate() && Date.timeIntervalSinceReferenceDate < timeoutTime) {
            RunLoop.current.run(mode: RunLoopMode.defaultRunLoopMode, before: Date(timeIntervalSinceNow: 5))
        }
    }
    
    // Place in a view controller while importing AVFoundation
//    let fileMgr = NSFileManager.defaultManager()
//    let path = NSHomeDirectory().stringByAppendingString("/Documents/1")
//    if let data = fileMgr.contentsAtPath(path) {
//        var error:NSError?
//        do {
//            try audioPlayer = AVAudioPlayer(data: data)
//        } catch let error as NSError {
//            Log.error(error.debugDescription)
//        }
//        audioPlayer.prepareToPlay()
//        audioPlayer.play()
//    }
}
