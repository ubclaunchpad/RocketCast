//
//  ViewController.swift
//  RocketCast
//
//  Created by Odin on 2016-08-27.
//  Copyright © 2016 UBCLaunchPad. All rights reserved.
//

import UIKit
import CoreData
class PodcastController: UIViewController {
    
    var mainView: PodcastView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if AudioEpisodeTracker.isPlaying {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(segueToPlayer) )
        }
    }
    
    fileprivate func setupView() {
        let viewSize = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        mainView = PodcastView.instancefromNib(viewSize)
        let listOfPodcasts = DatabaseUtil.getAllPodcasts()
        mainView?.podcastsToView = listOfPodcasts     
        let updatePodcastsButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateAllPodcasts))
        let goToItuneWebButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(segueToItuneWeb))

        navigationItem.leftBarButtonItems = [updatePodcastsButton, goToItuneWebButton]

        view.addSubview(mainView!)
        self.mainView?.viewDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeController {
            if let podcast = sender as? Podcast {
                let episodes = (podcast.episodes?.allObjects as! [Episode]).sorted(by: { $0.date!.compare($1.date!) == ComparisonResult.orderedDescending }) // swiftlint:disable:this force_cast
                destination.episodesInPodcast = episodes
                destination.selectedPodcast = podcast
            }
        }
    }
}
extension PodcastController:PodcastViewDelegate {

    func segueToPlayer() {
        guard !AudioEpisodeTracker.isTheAudioEmpty else {
            return
        }
        performSegue(withIdentifier: Segues.segueFromPodcastListToPlayer, sender: self)
    }
    
    func setSelectedPodcastAndSegue(selectedPodcast: Podcast) {
        performSegue(withIdentifier: Segues.segueFromPodcastToEpisode, sender: selectedPodcast)
    }
    
    func updateAllPodcasts() {
        
        AudioEpisodeTracker.resetAudioTracker()
        var currentPodcasts =  DatabaseUtil.getAllPodcasts()
        while (!currentPodcasts.isEmpty) {
            if let podcast = currentPodcasts.popLast() {
                if let rssFeedURL = podcast.rssFeedURL {
                    DatabaseUtil.deletePodcast(podcastTitle: podcast.title!)
                    CoreDataXMLParser(url:rssFeedURL)
                }
            }
        }
        navigationItem.rightBarButtonItem = nil
        let listOfPodcasts = DatabaseUtil.getAllPodcasts()
        mainView?.podcastsToView = listOfPodcasts
        self.mainView?.podcastView.reloadData()
    }
    
    func segueToItuneWeb() {
        performSegue(withIdentifier: Segues.segueToItuneWeb, sender: self)

    }
}
