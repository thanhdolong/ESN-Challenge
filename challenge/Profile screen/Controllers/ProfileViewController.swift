//
//  ProfileViewController.swift
//  challenge
//
//  Created by Thành Đỗ Long on 06/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit

protocol profileViewControllerDelegate: class {
    func logoutPressed()
}

class ProfileViewController: UITableViewController {
    private var indicator: UIView?
    private let theme = Theme()
    fileprivate var viewModel: ProfileViewModel
    weak var profileViewControllerDelegate: profileViewControllerDelegate?
    weak var loginViewControllerDelegate: LoginViewControllerDelegate?
    
    init(database: Database) {
        self.viewModel = ProfileViewModel(database: database)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func openSettings() {
        let vc = NavigationController(rootViewController: SettingsTableViewController.init())
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupTableView()
    }
    
    private func setupNavigation() {
        let settingsImage = UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate)
        let settingsButton = UIBarButtonItem(image: settingsImage, style: .plain, target: self, action: #selector(openSettings))
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    private func setupTableView() {
        tableView.dataSource = viewModel
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(AtributeCell.nib, forCellReuseIdentifier: AtributeCell.reuseIdentifier)
        tableView.register(ProfileHeaderCell.nib, forCellReuseIdentifier: ProfileHeaderCell.reuseIdentifier)
        tableView.register(LogoutCell.nib, forCellReuseIdentifier: LogoutCell.reuseIdentifier)
        tableView.register(CheckedLocationCell.nib, forCellReuseIdentifier: CheckedLocationCell.reuseIdentifier)
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        viewModel.profileViewModelDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel.fetchUser() == nil {
            let offset = navigationController?.navigationBar.frame.size.height ?? 0
            indicator = displayIndicator(onView: self.view, offset: -(offset * 2))
        } else {
            viewModel.reload()
        }
        
        viewModel.loadProfile()
        
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.backgroundView?.backgroundColor = .white
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func openLogin() {
        profileViewControllerDelegate?.logoutPressed()
    }
    
    func didRecieveDataUpdate() {
        tableView.reloadData()
        navigationController?.setNavigationBarHidden(false, animated: true)
        guard let indicator = indicator else { return }
        removeIndicator(indicator: indicator)
    }
}
