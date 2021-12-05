//
//  NativeAdCell.swift
//  NativeAppTutorial
//
//  Created by Mehedi on 5/12/21.
//

import UIKit
import GoogleMobileAds

class NativeAdCell: UICollectionViewCell {
    
    @IBOutlet weak var nativeAdView: GADNativeAdView!
    @IBOutlet weak var mediaView: GADMediaView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var adLabel: UILabel!
    @IBOutlet weak var starView: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var installButton: UIButton!
    
    
    static var id: String = {
        return "NativeAdCell"
    }()
    
    static var nib: UINib = {
        return UINib(nibName: id, bundle: nil)
    }()
    
    
    @IBAction func installButtonAction(_ sender: Any) {
        
    }
}
