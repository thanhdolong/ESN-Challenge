//
//  LeaderboardsViewModel.swift
//  challenge
//
//  Created by Thành Đỗ Long on 07/01/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol LeaderboardViewModelDelegate: class {
    func didRecieveDataUpdate()
}

enum LeaderboardSectionType {
    case header
    case body
}

protocol LeaderboardSection {
    var type: LeaderboardSectionType { get }
    var rowCount: Int { get }
}

class LeaderboardViewModel: NSObject {
    let database: Database
    var sections = [LeaderboardSection]()
    let api: ChallengeAPI = ChallengeAPI()
    
    weak var delegate: LeaderboardViewModelDelegate?
    
    init(database: Database) {
        self.database = database
    }

}

extension LeaderboardViewModel {
    func loadPlayers() {
        api.getLeaderboard { (respond) in
            do {
                if (try respond.getStatusCode() == 200) {
                    let playerObject = try respond.unwrap()
                    try self.database.delete(type: PlayerObject.self)
                    try self.database.insertObjects(playerObject, update: .all)
                    self.reload()
                } else {
                    print("Status code is not 200")
                }
            } catch let error as NetworkError {
                print("Network error: \(error.errorMessages)")
            }
            catch {
                print("Unexpected error: \(error).")
            }
        }
    }
    
    func reload() {
        sections.removeAll()
        guard let players = fetchLeaderboard() else { return }
        self.sections.append(BodySection(players: players))
        notifyControler()
    }
    
    private func fetchLeaderboard() -> [Player]? {
        let result = database.fetch(where: nil, sortDescriptors: nil) { (leaderboardObjectsResult: Results<PlayerObject>) -> [Player] in
            
            let result = leaderboardObjectsResult.map({ (playerObject) -> Player in
                return Player(object: playerObject)
                })
            
            return Array(result)
        }
        
        return result
    }
    
    private func notifyControler() {
        self.delegate?.didRecieveDataUpdate()
    }
}


extension LeaderboardViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rowCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = sections[indexPath.section]
        switch section.type {
        case .header:
            return UITableViewCell()
        case .body:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PlayerCell.reuseIdentifier, for: indexPath) as? PlayerCell, let item = section as? BodySection {
                cell.selectionStyle = .none
                cell.item = item.players[indexPath.row]
                return cell
            }
        }
        
        // return the default cell if none of above succeed
        return UITableViewCell()
    }
}
