//
//  SettingsTableViewController.swift
//  challenge
//
//  Created by Thành Đỗ Long on 25/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit
import StoreKit

class SettingsTableViewController: UITableViewController {
    fileprivate let viewModel = SettingsViewModel()
    private let safariController = SafariController()
    private let theme = Theme()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("Settings", comment: "")
        
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: theme.colours.primaryColor,
                                                                    NSAttributedString.Key.font: theme.fonts.navigationTitle]
        
        tableView.delegate = self
        tableView.dataSource = viewModel
        tableView.tableFooterView = UIView()

        let dismissIcon = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        let closeButton = UIBarButtonItem(image: dismissIcon, style: .plain, target: self, action: #selector(close))
        closeButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = closeButton
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 64))
        returnedView.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 16, y: 16, width: view.frame.size.width, height: 64 - 16))
        label.text = viewModel.tableView(tableView, titleForHeaderInSection: section)
        label.font = theme.fonts.titleMedium
        label.textColor = theme.colours.primaryColor
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch viewModel.sections[indexPath.section].items[indexPath.row] {
        case .blog:
            guard let url = URL(string: "https://www.esncz.org/") else {
                return
            }
            safariController.openUrl(url: url)
//        case .facebook:
//            UIApplication.tryURL(urls: [
//                "fb://profile/806356102767583",
//                "https://www.facebook.com/acotedajis/"
//                ])
//        case .instagram:
//            UIApplication.tryURL(urls: [
//                "instagram://user?username=acotedajis",
//                "https://www.instagram.com/acotedajis/?hl=cs"
//                ])
        case .rateTheApp:
            displayReviewController()
//        case .recomendTheApp:
        case .textMessage:
            let email = "thanh.dolong@gmail.com"
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url)
            }
        default:
            print("Default - \(indexPath)")
        }
    }
    
    func displayReviewController() {
        SKStoreReviewController.requestReview()
    }
}
