//
//  EpisodeViewDelegate.swift
//  RocketCast
//
//  Created by Odin on 2016-08-31.
//  Copyright © 2016 UBCLaunchPad. All rights reserved.
//

import Foundation

protocol EpisodeViewDelegate {
    func segueToPlayer()
    func setSelectedEpisode(selectedEpisode: Episode, index:Int, indexPathForEpisode: IndexPath)
    
}
