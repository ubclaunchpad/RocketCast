//
//  EpisodeView.swift
//  RocketCast
//
//  Created by Odin on 2016-08-31.
//  Copyright © 2016 UBCLaunchPad. All rights reserved.
//

import UIKit

class EpisodeView: UIView, UITableViewDelegate, UITableViewDataSource {
    var viewDelegate: EpisodeViewDelegate?
    var episodes = ["#845 - TJ Dillashaw, Duane Ludwig & Bas Rutten",
                    "#844 - Andreas Antonopoulos",
                    "#843 - Tony Hinchcliffe",
                    "#842 - Chris Kresser",
                    "#841 - Greg Fitzsimmons",
                    "#840 - Donald Cerrone"]

    @IBOutlet weak var EpisodeTable: UITableView!
    
    @IBAction func segueToPlayer(_ sender: AnyObject) {
        viewDelegate?.segueToPlayer()
    }
    class func instancefromNib(_ frame: CGRect) -> EpisodeView {
        let view = UINib(nibName: "EpisodeView", bundle: nil).instantiate(withOwner: nil, options: nil)[0]
            as! EpisodeView
        view.frame = frame
        view.EpisodeTable.delegate = view
        view.EpisodeTable.dataSource = view
        view.EpisodeTable.allowsSelection = true
        view.EpisodeTable.separatorStyle = UITableViewCellSeparatorStyle.none
        view.EpisodeTable.backgroundColor = UIColor.clear
        view.EpisodeTable.isOpaque = false
        return view
    }
    
    // returns an approiate number of rows depending on the section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  episodes.count
    }
    
    // Iiterates over every episode and creates a respective TableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nib_name = UINib(nibName: EpisodeViewConstants.cellViewNibName, bundle:nil)
        tableView.register(nib_name, forCellReuseIdentifier: EpisodeViewConstants.cellViewIdentifier)
        let cell = self.EpisodeTable.dequeueReusableCell(withIdentifier: EpisodeViewConstants.cellViewIdentifier, for: indexPath) as! EpisodeViewTableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.episodeHeader.text = episodes[indexPath.row]
        cell.tag = (indexPath as NSIndexPath).row
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}

