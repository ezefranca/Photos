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

class PhotoCell: UITableViewCell {
    
    static let reuseIdentifier: String? = "photocell"
    
    var viewModel: PhotosViewModel!{
        didSet{
            self.title.text = viewModel.title
            self.id.text = viewModel.title
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
    
    init(viewModel: PhotosViewModel){
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override func prepareForReuse() {
    //        self.imageCell.image = UIImage(named:"")
    //        // self.backgroundColor = UIColor.clearColor()
    //    }
}
