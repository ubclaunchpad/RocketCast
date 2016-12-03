//
//  PodcastViewCollectionViewCell.swift
//  RocketCast
//
//  Created by Milton Leung on 2016-11-09.
//  Copyright © 2016 UBCLaunchPad. All rights reserved.
//

import UIKit

class PodcastViewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var coverPhotoView: UIView!
    @IBOutlet weak var podcastTitle: UILabel!
    @IBOutlet weak var podcastAuthor: UILabel!
    
    @IBOutlet weak var photoWidth: NSLayoutConstraint!
    @IBOutlet weak var photoHeight: NSLayoutConstraint!
    var podcast: Podcast! {
        didSet {
            podcastTitle.text = podcast.title
            podcastAuthor.text = podcast.author
            let url = URL(string: (podcast.imageURL)!)
            if podcast.imageData == nil {
                DispatchQueue.global().async {
                    do {
                        let data = try Data(contentsOf: url!)
                        let coverPhoto = UIImageView()
                        coverPhoto.frame = self.coverPhotoView.bounds
                        coverPhoto.layer.cornerRadius = 18
                        coverPhoto.layer.masksToBounds = true
                        self.podcast.imageData = data as NSData?
                        DatabaseUtil.saveContext()
                        DispatchQueue.main.async {
                            coverPhoto.image = UIImage(data: data)
                            self.coverPhotoView.addSubview(coverPhoto)
                            
                        }
                        
                    } catch let error as NSError{
                        Log.error("Error: " + error.debugDescription)
                    }
                }
            } else {
                DispatchQueue.global().async {
                    do {
                        let data = try Data(contentsOf: url!)
                        let coverPhoto = UIImageView()
                        coverPhoto.frame = self.coverPhotoView.bounds
                        coverPhoto.layer.cornerRadius = 18
                        coverPhoto.layer.masksToBounds = true
                        DispatchQueue.main.async {
                            coverPhoto.image = UIImage(data: self.podcast.imageData as! Data)
                            self.coverPhotoView.addSubview(coverPhoto)
                            
                        }
                        
                    } catch let error as NSError{
                        Log.error("Error: " + error.debugDescription)
                    }
                }
                    
    
                
            }
            

            //Check if the podcast image has been downloaded. If it hasn't then download and save it to core data. Otherwise, we have already downloaded this image and we can display it right away.
//            guard let imageData = podcast.imageData else {
//                let url = URL(string: (podcast.imageURL)!)
//               
//                DispatchQueue.global().async {
//                    do {
//                        let coverPhoto = UIImageView()
//                        coverPhoto.frame = self.coverPhotoView.bounds
//                        coverPhoto.layer.cornerRadius = 18
//                        coverPhoto.layer.masksToBounds = true
//                        let data = try Data(contentsOf: url!)
//                        self.podcast.imageData = data as NSData?
//                        DispatchQueue.main.async {
//                            coverPhoto.image = UIImage(data: data)
//                            self.coverPhotoView.addSubview(coverPhoto)
//                        }
//                        
//                    } catch let error as NSError{
//                        Log.error("Error: " + error.debugDescription)
//                    }
//                }
//                    return
//            }
//            
//            let coverPhoto = UIImageView()
//            coverPhoto.frame = self.coverPhotoView.bounds
//            coverPhoto.layer.cornerRadius = 18
//            coverPhoto.layer.masksToBounds = true
//            coverPhoto.image = UIImage(data: (podcast.imageData as? Data)!)
//            self.coverPhotoView.addSubview(coverPhoto)
//            
            
            

        }
    }
    
    var size: Int! {
        didSet {
            photoWidth.constant = CGFloat(size)
            photoHeight.constant = CGFloat(size)
        }
    }
    
    func setStyling() {
        let effectsLayer = coverPhotoView.layer
        effectsLayer.cornerRadius = 14
        effectsLayer.shadowColor = UIColor.black.cgColor
        effectsLayer.shadowOffset = CGSize(width: 0, height: 0)
        effectsLayer.shadowRadius = 4
        effectsLayer.shadowOpacity = 0.4
        effectsLayer.shadowPath = UIBezierPath(roundedRect: CGRect(x:coverPhotoView.frame.origin.x, y:coverPhotoView.frame.origin.y, width: photoWidth.constant, height:photoHeight.constant), cornerRadius: coverPhotoView.layer.cornerRadius).cgPath
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
