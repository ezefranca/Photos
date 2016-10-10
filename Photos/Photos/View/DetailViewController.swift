//
//  DetailViewController.swift
//  
//
//  Created by Ezequiel on 09/10/16.
//
//

import UIKit
import RxCocoa
import RxSwift
import Font_Awesome_Swift

class DetailViewController: UIViewController, NetworkManager, CheckDependencies, Alerts {
    
    static let identifier = "DetailViewController"
    static let segue = "DetailViewController"
    typealias T = PhotosViewModel
    
    @IBOutlet private var imageDetails: UIImageView!
    @IBOutlet private var albumID: UILabel!
    @IBOutlet private var imageID: UILabel!
    @IBOutlet private var imageTitle: UILabel!
    
    //TODO: A Controller não pode existir sem esse amiguinho aqui
    var model:PhotosViewModel?
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies(model)
        display()
    }
    
    func assertDependencies<T>(dependencies: T?){
        assert(dependencies != nil)
    }
    
    func display() {
        
        guard let viewModel = model else {
            showMessage(Options(message: "Falha no carregamento dos dados", title: "Alerta", type: .error))
            return //
        }
        
        imageTitle.text = model!.title
        albumID.setFAText(prefixText: "", icon: FAType.FAPictureO, postfixText: String(viewModel.albumId!), size: 12.0, iconSize: 12.0)
        imageID.setFAText(prefixText: "", icon: FAType.FAFileO, postfixText: String(viewModel.internalIdentifier!.advancedBy(4)), size: 12.0, iconSize: 12.0)
        imageDetails!.pin_updateWithProgress = true
        imageDetails.pin_setImageFromURL(NSURL(string: viewModel.url!), placeholderImage: UIImage(named: "placeholder")) { (result) in
            
            self.imageDetails!.image!.getColors { colors in
                self.navigationController?.navigationBar.barTintColor = colors.backgroundColor
            }
            
        }
    }
    
}
