//
//  ViewController.swift
//  test
//
//  Created by Thành Đỗ Long on 29/10/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit
import CoreLocation
import Crashlytics
import SwinjectStoryboard

class LeaderboardsViewController: UITableViewController {
    private var indicator: UIView?
    fileprivate var viewModel: LeaderboardViewModel
    private let theme = Theme()
    
    init(database: Database) {
        self.viewModel = LeaderboardViewModel(database: database)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        // Code to refresh table view
        viewModel.loadPlayers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        viewModel.delegate = self
        
        let offset = navigationController?.navigationBar.frame.size.height ?? 0
        indicator = displayIndicator(onView: self.view, offset: -(offset * 2))
        viewModel.loadPlayers()
        setupRefreshControl()
    }
    

    private func setupNavigation() {
        navigationItem.title = NSLocalizedString("Leaderboards", comment: "")

        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: theme.colours.primaryColor,
                                                                    NSAttributedString.Key.font: theme.fonts.navigationTitle]
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl!.attributedTitle = NSAttributedString(string: "Fetching Leaderboards.")
    }
    
    private func setupTableView() {
        tableView.dataSource = viewModel
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(PlayerCell.nib, forCellReuseIdentifier: PlayerCell.reuseIdentifier)
        
    }
}

extension LeaderboardsViewController: LeaderboardViewModelDelegate {
    func didRecieveDataUpdate() {
        tableView.reloadData()
        guard let indicator = indicator else { return }
        removeIndicator(indicator: indicator)
        refreshControl!.endRefreshing()
    }
}
