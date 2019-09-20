//
//  ProfileViewModel.swift
//  challenge
//
//  Created by Thành Đỗ Long on 09/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

enum ProfileSectionType {
    case header
    case aboutMe
    case locations
    case logout
}

protocol ProfileSection {
    var type: ProfileSectionType { get }
    var rowCount: Int { get }
    var sectionTitle: String?  { get }
}

protocol ProfileViewModelDelegate: class {
    func didRecieveDataUpdate()
    func openLogin()
}

class ProfileViewModel: NSObject {
    private let token: Token = Token()
    var sections = [ProfileSection]()
    let database: Database
    let api: ChallengeAPI = ChallengeAPI()
    
    weak var profileViewModelDelegate: ProfileViewModelDelegate?
    
    init(database: Database) {
        self.database = database
    }
    
}

extension ProfileViewModel {
    func loadProfile() {
        api.getProfile(completion: { (respond) in
            do {
                if (try respond.getStatusCode() == 200) {
                    let userObject = try respond.unwrap()
                    try self.database.insertObjects(userObject, update: .all)
                    self.reload()
                } else {
                    try self.database.delete(type: UserObject.self)
                    self.token.deleteAccessToken()
                }
            } catch let error as NetworkError {
                self.token.deleteAccessToken()
                print("Network error: \(error.errorMessages)")
            }
            catch {
                print("Unexpected error: \(error).")
            }
        })
    }
    
    func reload() {
        sections.removeAll()
        guard let user = fetchUser() else { return }
        self.sections.append(ProfileHeaderSection(user: user))
        self.sections.append(AboutmeSection(user: user))
        self.sections.append(CheckedLocationsSection(locations: user.locations))
        self.sections.append(LogoutSection())
        self.notifyControler()
    }
    
    func fetchUser() -> User? {
        let result = database.fetch(where: nil, sortDescriptors: nil, transformer: { (result: Results<UserObject>) -> User? in
            guard let userObject = result.first else { return nil }
            return User(object: userObject)
        })
        
        return result
    }
    
    private func notifyControler() {
        self.profileViewModelDelegate?.didRecieveDataUpdate()
    }
}

extension ProfileViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].sectionTitle
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section.type {
        case .aboutMe:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AtributeCell.reuseIdentifier, for: indexPath) as? AtributeCell, let item = section as? AboutmeSection {
                cell.item = item.attributes[indexPath.row]
                cell.selectionStyle = .none
                return cell
            }
        case .header:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.reuseIdentifier, for: indexPath) as? ProfileHeaderCell, let item = section as? ProfileHeaderSection {
                cell.name = "Howdy, \(item.name)"
                cell.checkedLocation = "Checked location \(item.checkedLocation)"
                cell.selectionStyle = .none
                return cell
            }
        case .logout:
            if let cell = tableView.dequeueReusableCell(withIdentifier: LogoutCell.reuseIdentifier, for: indexPath) as? LogoutCell {
                cell.selectionStyle = .none
                cell.logoutButton.addTarget(self, action: #selector(logoutUser) , for: .touchUpInside)
                return cell
            }
        case .locations:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CheckedLocationCell.reuseIdentifier, for: indexPath) as? CheckedLocationCell, let item = section as? CheckedLocationsSection {
                cell.item = item.locations[indexPath.row]
                return cell
            }
        }
        
        // return the default cell if none of above succeed
        return UITableViewCell()
    }
}

extension ProfileViewModel {
    @objc func logoutUser() {
        do { try self.database.delete(type: UserObject.self) }
        catch { print("Unexpected error: \(error).") }
        
        sections.removeAll()
        token.deleteAccessToken()
        self.notifyControler()
        
        profileViewModelDelegate?.openLogin()
    }
}
