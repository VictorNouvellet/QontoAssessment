//
//  MainViewController.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Interface Builder vars
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Injected vars
    
    var interactor: MainInteractorInterface!
}

//MARK: - View management methods

extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor.callbackModelUpdate = { [weak self] (viewModel) in
            guard let self = self else { return }
            self.titleLabel.text = viewModel.title
        }
        
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactor.onViewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: - Setup methods

extension MainViewController {
    func setup() {

    }
}
