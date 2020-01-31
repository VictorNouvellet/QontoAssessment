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
    
    enum Section: CaseIterable {
        case main
    }
    
    //MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Injected vars
    
    var interactor: MainInteractorInterface!
    
    // MARK: Private vars
    
    var dataSource: UICollectionViewDiffableDataSource<Section, UserMainViewModel>!
}

//MARK: - View management methods

extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Users", comment: "")
        
        self.interactor.callbackModelUpdate = { [weak self] (viewModel) in
            guard let self = self else { return }
            self.updateCollectionView(with: viewModel.userList)
        }
        
        self.setup()
        self.interactor.onViewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactor.onViewDidAppear {
            DispatchQueue.main.async(execute: { [weak self] in
                self?.collectionView.refreshControl?.endRefreshing()
            })
        }
    }
}

//MARK: - Setup methods

extension MainViewController {
    func setup() {
        self.setupCollectionView()
        self.setupRefreshControl()
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.dataSource = UICollectionViewDiffableDataSource<Section, UserMainViewModel>(collectionView: collectionView) { (collectionView, indexPath, model) -> UICollectionViewCell? in
            let cell: UserCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(withFirstname: model.firstname, lastname: model.lastname, email: model.email)
            return cell
        }
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(manualRefreshTriggered), for: .valueChanged)
        self.collectionView.addSubview(refreshControl)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.refreshControl = refreshControl
    }
}

//MARK: - Internal methods

extension MainViewController {
    
    @objc func manualRefreshTriggered() {
        self.interactor.onTransfersListManualRefresh {
            DispatchQueue.main.async(execute: { [weak self] in
                self?.collectionView.refreshControl?.endRefreshing()
            })
        }
    }
}

//MARK: - Private methods

private extension MainViewController {
    
    func updateCollectionView(with users: [UserMainViewModel]?) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserMainViewModel>()
        if let users = users {
            snapshot.appendSections([.main])
            snapshot.appendItems(users, toSection: .main)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - UICollectionViewFlowLayout methods

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let kHeight = 80
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(kHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defer {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
        guard let user = self.dataSource.itemIdentifier(for: indexPath) else { return }
        guard let transfersListVC = DetailBuilder.getView(user: user) else { return }
        self.navigationController?.pushViewController(transfersListVC, animated: true)
    }
}
