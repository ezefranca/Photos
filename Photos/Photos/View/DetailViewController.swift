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

class DetailViewController: UIViewController, NetworkManager {
    
    static let identifier = "DetailViewController"
    
    @IBOutlet private var imageDetails: UIImageView!
    @IBOutlet private var albumID: UILabel!
    @IBOutlet private var imageID: UILabel!
    @IBOutlet private var imageTitle: UILabel!
    
    //TODO: A Controller não pode existir sem esse amiguinho aqui
    var model:PhotosViewModel?
    
    private var disposeBag = DisposeBag()
    
    private var _model: Variable<PhotosViewModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //DetailViewController
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
