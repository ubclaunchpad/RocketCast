//
//  testNormalPodcastXML.swift
//  RocketCast
//
//  Created by James Park on 2016-09-12.
//  Copyright © 2016 UBCLaunchPad. All rights reserved.
//

import Foundation

struct testNormalPodcastXML {
    
    let fileName = "testNormalPodcastXML"
    
    let title = "QuantumSpark"
    let author = "James Park"
    let description = "A dank podcast"
    let imageURL = "JamesPark.jpg"
    
   private let expectedEpisode1:[String:String] =
        [ "title" : "Quantum Superposition",
          "description": "exploring states of particles",
          "author" : "Jon Mercer",
          "date": "Thu, 16 Jun 2005 5:00:00 PST",
          "duration" : "01:07:59",
          "image" : "JONMERCER.jpg",
          "audio" : "http://www.yourserver.com/podcast_fileONE.mp3"]
    
    
    private let expectedEpisode2:[String:String] =
        [ "title" : "Photon",
          "description": "lights",
          "author" : "Kelvin Chan",
          "date": "Fri, 17 Jun 2005 5:00:00 PST",
          "duration" : "12:07:59",
          "image" : "KELVINCHAN.jpg",
          "audio" : "http://www.yourserver.com/podcast_fileTWO.mp3"]
    
    var expectedEpisodes = [[String:String]]()
    
    init () {
        expectedEpisodes.append(expectedEpisode1)
        expectedEpisodes.append(expectedEpisode2)
    }
    
    
}
