//
//  SettingsViewModel.swift
//  challenge
//
//  Created by Thành Đỗ Long on 26/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import UIKit

enum SettingsSectionType {
    case general
    case links
    case more
}

enum SettingsItem {
    case blog
    case instagram
    case rateTheApp
    case recomendTheApp
    case textMessage
    case termsOfService
    case help
    case addLocation
    case logout
    
    var text: String {
        switch self {
        case .blog:
            return "Check out official site"
        case .instagram:
            return "Follow us on Instagram"
        case .rateTheApp:
            return "Rate the app"
        case .recomendTheApp:
            return "Share with Friends"
        case .textMessage:
            return "Contact us"
        case .termsOfService:
            return "Term of service"
        case .help:
            return "Get help"
        case .addLocation:
            return "Add new location"
        case .logout:
            return "Logout"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .blog:
            return UIImage(named: "web")
        case .instagram:
            return UIImage(named: "instagram")
        case .rateTheApp:
            return UIImage(named: "vote")
        case .recomendTheApp:
            return UIImage(named: "recommend")
        case .textMessage:
            return UIImage(named: "message")
        case .termsOfService:
            return UIImage(named: "sync")
        case .help:
            return UIImage(named: "sync")
        case .addLocation:
            return UIImage(named: "sync")
        case .logout:
            return nil
        }
    }
}

protocol SettingsSection {
    var type: SettingsSectionType { get }
    var sectionTitle: String? { get }
    var items: [SettingsItem] { get }
    var rowCount: Int { get }
}

class SettingsViewModel: NSObject {
    var sections = [SettingsSection]()
    
    override init() {
//        sections.append(LocationSection(user: Token(), items: [.sync, .help]))
        sections.append(LinkSection(items: [.blog, .instagram]))
        sections.append(MoreSection(items: [.rateTheApp,.recomendTheApp,.textMessage, .termsOfService]))
    }
}

extension SettingsViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        

        
        let cell = UITableViewCell()
        let theme = Theme()
        
        cell.textLabel?.textColor = theme.colours.secondaryColor
        cell.textLabel?.font = theme.fonts.bodyRegular

        cell.textLabel?.text = section.items[indexPath.row].text
        cell.imageView?.image = section.items[indexPath.row].icon
        cell.accessoryType = .disclosureIndicator
    
        
        return cell
    }
}
