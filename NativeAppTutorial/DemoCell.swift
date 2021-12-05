//
//  DemoCell.swift
//  NativeAppTutorial
//
//  Created by Mehedi on 1/12/21.
//

import UIKit

class DemoCell: UICollectionViewCell {
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var centerLabel: UILabel!
    static let id = {
        "DemoCell"
    }()
    
    static let nib = {
        UINib(nibName: id, bundle: nil)
    }()
    
}
