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

class PhotoCell: UITableViewCell {
    
    static let reuseIdentifier: String? = "photocell"
    
    var viewModel: PhotosViewModel!{
        didSet{
            self.title.text = viewModel.title
            
            self.albumid.setFAText(prefixText: "", icon: FAType.FAPictureO, postfixText: String(viewModel.albumId!), size: 12.0, iconSize: 12.0)
            self.id.setFAText(prefixText: "", icon: FAType.FAFileO, postfixText: String(viewModel.internalIdentifier!), size: 12.0, iconSize: 12.0)
            self.imageCell!.pin_updateWithProgress = true
            //self.line.image = UIImage.imageWithColor(UIColor.clearColor())
            self.imageCell.pin_setImageFromURL(NSURL(string: viewModel.thumbnailUrl!), placeholderImage: UIImage(named: "placeholder")) { (result) in
                
                self.imageCell!.image!.getColors { colors in
                    
                    ///       self.line.image = UIImage.imageWithColor(colors.backgroundColor)
                    
                }
                
            }
        }
    }
    
    
    @IBOutlet var imageCell: UIImageView!
    //        {
    //        didSet{
    ////            self.imageCell!.image!.getColors { colors in
    ////                self.contentView.backgroundColor = colors.backgroundColor
    ////                self.title.textColor = colors.primaryColor
    ////                self.id.textColor = colors.secondaryColor
    ////                self.albumid.textColor = colors.detailColor
    //            }
    //        }
    //    }
    @IBOutlet var title: UILabel!
    @IBOutlet var id: UILabel!
    @IBOutlet var albumid: UILabel!
    @IBOutlet var line: UIImageView!
    
    func setup(viewModel: PhotosViewModel){
        self.viewModel = viewModel
    }
    
    //    override func prepareForReuse() {
    //        self.imageCell.image = UIImage(named:"")
    //        // self.backgroundColor = UIColor.clearColor()
    //    }
}
