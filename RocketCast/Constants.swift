//
//  Constants.swift
//  RocketCast
//
//  Created by James Park on 2016-08-31.
//  Copyright © 2016 UBCLaunchPad. All rights reserved.
//

import Foundation
import CoreData

typealias PodcastWebURL = String
typealias ImageWebURL = String
typealias AudioWebURL = String
typealias PodcastStorageURL = String
typealias ImageStorageURL = String
typealias AudioStorageURL = String
typealias XML = String

enum  Segues {
  static let segueFromPodcastToEpisode = "segueFromPodcastToEpisode"
  static let segueFromEpisodeToPlayer = "segueFromEpisodeToPlayer"
  static let segueToBackEpisodes = "segueToBackEpisodes"
  static let segueFromAddUrlToPodcastList = "segueFromAddUrlToPodcastList"
  static let segueFromPodcastListToAddUrl = "segueFromPodcastListToAddUrl"
  static let segueFromPodcastListToPlayer = "segueFromPodcastListToPlayer"
  static let segueToItuneWeb = "segueToItuneWeb"
  static let segueFromItuneAPIToPodcast = "segueFromItuneAPIToPodcast"
  static let segueFromItuneWebToAddUrl = "segueFromItuneWebToAddUrl"
}

enum SpeedRates { // swiftlint:disable:this force_cast
    static let single:Float = 1
    static let double:Float = 2
    static let triple:Float = 3
}

enum PodcastInfoStrings {
    static let singularHour = "hour"
    static let pluralHour = "hours"
    static let minute = "min"
}

enum EpisodeViewConstants {
    static let cellViewNibName = "EpisodeViewTableViewCell"
    static let cellViewIdentifier = "episodeviewCell"
}
let dateFormatString = "EEE, dd MMM yyyy HH:mm:ss zzz"

let testRSSFeed = "https://s3-us-west-2.amazonaws.com/podcastassets/Episodes/testPodcastMadeup.xml"

struct xmlKeyTags { // swiftlint:disable:this force_cast
    static let episodeTag = "item"
    static let podcastImage = "itunes:image"
    static let imageLink = "href"
    static let startTagAudioURL = "enclosure"
    static let audioURL = "url"
    static let title = "title"
    static let description = "itunes:summary"
    static let author = "itunes:author"
    static let publishedDate = "pubDate"
    static let authorEpisodeTagTwo = "dc:creator"
    static let descriptionTagTwo = "description"
    static let duration = "itunes:duration"
    static let unwantedStringInTag = ["<p>", "</p>", "\t", "<span>", "</span>"]
}

let stringsToRemove = ["http://", "/", "."]


enum EntityName {
    static let Podcast = "Podcast"
    static let Episode = "Episode"
}

/**
 A log level of debug will print out all levels above it.
 So a log level of WARN will print out WARN, ERROR, and TEST
 */
enum LogLevel {
    static let lvl = LogLevelChoices.DEBUG
}
