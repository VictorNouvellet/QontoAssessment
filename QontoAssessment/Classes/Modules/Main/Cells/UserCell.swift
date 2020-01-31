//
//  UserCell.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

final class UserCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: Internal methods
    
    func configure(withFirstname firstname: String, lastname: String, email: String) {
        self.firstnameLabel.text = firstname
        self.lastnameLabel.text = lastname
        self.emailLabel.text = email
    }
}
