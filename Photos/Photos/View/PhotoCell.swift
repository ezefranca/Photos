//
//  PhotoCell.swift
//  Photos
//
//  Created by Ezequiel on 07/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import UIKit
import UIImageColors
import PINRemoteImage
import Font_Awesome_Swift
import RxSwift
import RxCocoa

class PhotoCell: UITableViewCell {
    static let reuseIdentifier: String = "photocell"
    
    private var viewModel: PhotosViewModel!{
        
        didSet{
            
            title.text = viewModel.title
            albumid.setFAText(prefixText: "", icon: FAType.FAPictureO, postfixText: String(viewModel.albumId!), size: 12.0, iconSize: 12.0)
            id.setFAText(prefixText: "", icon: FAType.FAFileO, postfixText: String(viewModel.internalIdentifier!.advancedBy(4)), size: 12.0, iconSize: 12.0)
            imageCell!.pin_updateWithProgress = true
            imageCell.pin_setImageFromURL(NSURL(string: viewModel.thumbnailUrl!), placeholderImage: UIImage(named: "placeholder")) { (result) in
                
                self.imageCell!.image!.getColors { colors in
                    self.colorDominant = colors.backgroundColor
                }
                
            }
        }
    }
    
    
    @IBOutlet private var imageCell: UIImageView!
    @IBOutlet private var title: UILabel!
    @IBOutlet private var id: UILabel!
    @IBOutlet private var albumid: UILabel!
    @IBOutlet private var line: UIImageView!
    private var colorDominant : UIColor?
    
    func setup(viewModel: PhotosViewModel){
        self.viewModel = viewModel
    }
}
