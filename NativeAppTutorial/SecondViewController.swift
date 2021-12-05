//
//  SecondViewController.swift
//  NativeAppTutorial
//
//  Created by Mehedi on 1/12/21.
//

import UIKit
import GoogleMobileAds

class SecondViewController: UIViewController {

    let textSet: [String] = ["ONE", "TWO","THREE","FOUR","FIVE","SIX","SEVEN","EIGHT","NINE", "TEN"]
    var imageSet: [UIImage] = [UIImage]()
    let cellGap = CGFloat(15)
    let cellInset = CGFloat(15)
    let uId = "ca-app-pub-3940256099942544/3986624511"
    let numberOfAds = 3
    var nativeAd = GADNativeAd()
    var adLoader: GADAdLoader!
    
    @IBOutlet weak var demoCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        demoCollectionView.register(DemoCell.nib, forCellWithReuseIdentifier: DemoCell.id)
        demoCollectionView.register(NativeAdCell.nib, forCellWithReuseIdentifier: NativeAdCell.id)
        
        demoCollectionView.delegate = self
        demoCollectionView.dataSource = self
        nativeAd.delegate = self
        setupData()
        loadAd()
        
    }
    
    func imageOfStars(from starRating: NSDecimalNumber?) -> UIImage? {
      guard let rating = starRating?.doubleValue else {
        return nil
      }
      if rating >= 5 {
        return UIImage(named: "stars_5")
      } else if rating >= 4.5 {
        return UIImage(named: "stars_4_5")
      } else if rating >= 4 {
        return UIImage(named: "stars_4")
      } else if rating >= 3.5 {
        return UIImage(named: "stars_3_5")
      } else {
        return nil
      }
    }
    
    private func loadAd() {
        let options = GADMultipleAdsAdLoaderOptions()
        options.numberOfAds = numberOfAds
        adLoader = GADAdLoader(adUnitID: uId,
                               rootViewController: self,
                               adTypes: [.native],
                               options: [options]
        )
        adLoader.delegate = self
        adLoader.load(GADRequest())
    }
    
    private func setupData() {
        for i in 1...12 {
            imageSet.append(UIImage(named: "cellBg\(i)")!)
        }
    }
    
    private func setupData(cell: NativeAdCell) {
        nativeAd.delegate = self
        nativeAd.rootViewController = self
        cell.nativeAdView.nativeAd = nativeAd
        cell.headingLabel.text = nativeAd.advertiser
        //cell.adLabel.text = nativeAd.advertiser
        cell.subTitleLabel.text = nativeAd.headline
        
        cell.mediaView.mediaContent = nativeAd.mediaContent
        let mediaContet = nativeAd.mediaContent
        if mediaContet.hasVideoContent {
            mediaContet.videoController.delegate = self
        }
        
        cell.iconView.image = nativeAd.icon?.image
        cell.installButton.setTitle(nativeAd.callToAction, for: .normal)
    }
    
}

extension SecondViewController: GADNativeAdLoaderDelegate {
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        self.nativeAd = nativeAd
        print("ad loader did receive")
        demoCollectionView.reloadData()
    }
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        print("Ad loader finish")
    }
}

extension SecondViewController: UICollectionViewDelegate {
    
}

extension SecondViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.main.bounds.width - 2*cellInset - cellGap)/2
        let height = (width * 4) / 3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: cellInset, left: cellInset, bottom: cellInset, right: cellInset)
    }
    
}

extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textSet.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row < 1 ? indexPath.row : indexPath.row - 1
        if indexPath.row == 1 {
            let cell = demoCollectionView.dequeueReusableCell(withReuseIdentifier: NativeAdCell.id, for: indexPath) as! NativeAdCell
            setupData(cell: cell)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DemoCell.id, for: indexPath) as! DemoCell
            cell.bgImage.image = imageSet[index]
            cell.centerLabel.text = textSet[index]
            cell.backgroundColor = UIColor.red
            return cell
        }
    }
}

extension SecondViewController: GADNativeAdDelegate {
    func nativeAdDidRecordImpression(_ nativeAd: GADNativeAd) {
      print("The native ad was shown.")
    }

    func nativeAdDidRecordClick(_ nativeAd: GADNativeAd) {
      print("The native ad was clicked on.")
    }

    func nativeAdWillPresentScreen(_ nativeAd: GADNativeAd) {
      print("The native ad will present a full screen view.")
    }

    func nativeAdWillDismissScreen(_ nativeAd: GADNativeAd) {
      print("The native ad will dismiss a full screen view.")
    }

    func nativeAdDidDismissScreen(_ nativeAd: GADNativeAd) {
      print("The native ad did dismiss a full screen view.")
    }

    func nativeAdWillLeaveApplication(_ nativeAd: GADNativeAd) {
      print("The native ad will cause the application to become inactive")
    }
}

extension SecondViewController: GADVideoControllerDelegate {
    
}
