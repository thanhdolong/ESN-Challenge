//
//  LocationAPI.swift
//  challenge
//
//  Created by Thành Đỗ Long on 13/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

class ChallengeAPI {
    private let leaderboardRouter = Manager<LeaderboardEndPoint>()
    private let locationRouter = Manager<LocationEndPoint>()
    private let authRouter = Manager<AuthEndPoint>()
    private let profileRouter = Manager<ProfileEndPoint>()
    private let token = Token()
    
    // mARK: Leaderboard endpoint
    
    func getLeaderboard(completion: @escaping(ApiResult<PlayerObject>) -> Void) {
        let params = ["limit": 10, "offset": 0]
        leaderboardRouter.getJson(resourceUrl: .allPlayers, params: params, paramsHead: nil) { (data, header, error) in
            print("fiiiha \(data ?? "nothing")")
            completion(ApiResult(data, header, error))
        }
    }
    
    // MARK: Profile endpoint
    
    func getProfile( completion: @escaping(ApiResult<UserObject>) -> Void) {
        let header = ["X-Auth-Token": token.accessToken ?? ""]
        
        profileRouter.getJson(resourceUrl: .profile, params: nil, paramsHead: header) { (data, header, error) in
            completion(ApiResult(data, header, error))
        }
    }
    
    // MARK: Location endpoint
    
    func sendLocationCheck(location: Int, completion: @escaping (ApiResult<LocationObject>) -> Void) {
        print("posilam tento location: \(location)")
        let params = ["location": location]
        let header = ["X-Auth-Token": token.accessToken ?? "",
                      "Pragma" : "no-cache",
                      "Cache-Control" : "no-cache, no-store, must-revalidate"]
        
        locationRouter.post(resourceUrl: .allLocation, paramsHead: header, paramsBody: params) { (data, header, error) in
            completion(ApiResult(data, header, error))
        }
    }
    
    func geAllLocations( completion: @escaping (ApiResult<LocationObject>) -> Void )  {
        let paramsHead = ["hash": LocalDatabase.databaseHash ?? ""]
        
        locationRouter.getJson(resourceUrl: .allLocation, params: nil, paramsHead: paramsHead) { (data, header, error) in
            completion(ApiResult(data, header, error))
        }
    }
    
    func geAllLocationsAsObjects( completion: @escaping (ApiResult<LocationObject>) -> Void )  {
        locationRouter.getJson(resourceUrl: .allLocation, params: nil, paramsHead: ["hash": LocalDatabase.databaseHash ?? ""]) { (data, header, error) in
            completion(ApiResult(data, header, error))
        }
    }
    
    // MARK: Auth endpoint
    
    func login(email: String, password: String, completion: @escaping (Any?, NetworkError?) -> Void ) {
        let params = [
            "email": email,
            "password": password
        ]
    
        authRouter.post(resourceUrl: .login, paramsHead: nil, paramsBody: params) { (data, header, error) in
            guard let data = data, header?.statusCode.isSuccessHTTPCode == true else {
                return completion(nil, error)
            }
            
            completion(data, nil)
        }
    }
    
    
}

