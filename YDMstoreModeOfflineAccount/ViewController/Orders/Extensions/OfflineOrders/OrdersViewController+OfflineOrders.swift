//
//  OrdersViewController+OfflineOrders.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 22/02/21.
//

import UIKit

import YDMOfflineOrders

extension OrdersViewController: YDMSOfflineOrdersDelegate {
  func toggleNavShadowYDMSO(_ show: Bool) {
    toggleNavShadow(show)
  }
}
