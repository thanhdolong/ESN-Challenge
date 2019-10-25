//
//  Safari.swift
//  challenge
//
//  Created by Thành Đỗ Long on 26/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

import UIKit
import SafariServices

class SafariController: NSObject {
    func openUrl(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
//        safariVC.preferredControlTintColor = Appearance.shared().mainColor^
        if let topController = UIApplication.topViewController() {
            topController.present(safariVC, animated: true, completion: nil)
        }
    }
}

extension SafariController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//        UIApplication.shared.statusBarView?.backgroundColor = .white
    }
}
