//
//  DetailViewController.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    
    //MARK: - Interface Builder vars
    
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    
    // MARK: - Injected vars
    
    var interactor: DetailInteractorInterface!
}

//MARK: - View management methods

extension DetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor.callbackModelUpdate = { [weak self] (viewModel) in
            guard let self = self else { return }
            self.firstnameLabel.text = viewModel.user?.firstname
            self.lastnameLabel.text = viewModel.user?.lastname
        }
        
        self.setup()
        self.interactor.onViewDidLoad()
    }
}

//MARK: - Setup methods

extension DetailViewController {
    func setup() {
        // Nothing to do
    }
}
