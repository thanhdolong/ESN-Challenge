//
//  SettingsViewModel.swift
//  challenge
//
//  Created by Thành Đỗ Long on 26/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import UIKit

enum SectionType {
    case general
    case links
    case more
}

enum Item {
    case blog
    case facebook
    case instagram
    case rateTheApp
    case recomendTheApp
    case textMessage
    
    var text: String {
        switch self {
        case .blog:
            return "Official ESN site"
        case .facebook:
            return "Facebook"
        case .instagram:
            return "Instagram"
        case .rateTheApp:
            return "Rate the app"
        case .recomendTheApp:
            return "Reccomend the app"
        case .textMessage:
            return "Text message"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .blog:
            return UIImage(named: "web")
        case .facebook:
            return UIImage(named: "facebook")
        case .instagram:
            return UIImage(named: "instagram")
        case .rateTheApp:
            return UIImage(named: "vote")
        case .recomendTheApp:
            return UIImage(named: "recommend")
        case .textMessage:
            return UIImage(named: "message")
        }
    }
}

protocol Section {
    var type: SectionType { get }
    var sectionTitle: String { get }
    var items: [Item] { get }
    var rowCount: Int { get }
}

class SettingsViewModel: NSObject {
    var sections = [Section]()
    
    override init() {
        sections.append(LinkSection())
        sections.append(MoreSection())
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
        switch section.type {
        case .general:
           return UITableViewCell()
        case .links:
            if let item = section as? LinkSection {
                cell.textLabel?.text = item.items[indexPath.row].text
                cell.imageView?.image = item.items[indexPath.row].icon
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        case .more:
            if let item = section as? MoreSection {
                cell.textLabel?.text = item.items[indexPath.row].text
                cell.imageView?.image = item.items[indexPath.row].icon
                cell.accessoryType = .disclosureIndicator
                return cell
            }

        }
        
        
        return UITableViewCell()
    }
}
