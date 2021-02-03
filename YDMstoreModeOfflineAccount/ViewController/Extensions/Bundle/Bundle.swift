//
//  Bundle.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Eduardo Emanuel on 03/02/21.
//

import Foundation

extension Bundle {
    static var localBundle: Bundle {
        return Bundle(for: YDMstoreFramework.self)
    }
}
