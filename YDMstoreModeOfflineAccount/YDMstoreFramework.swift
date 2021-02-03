//
//  YDMstoreFramework.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Eduardo Emanuel on 03/02/21.
//

import Foundation

public class YDMstoreFramework {
    
    // MARK: - Properties
    
    private static var sharedManager: YDMstoreFramework {
        let manager = YDMstoreFramework()
        return manager
    }
}
