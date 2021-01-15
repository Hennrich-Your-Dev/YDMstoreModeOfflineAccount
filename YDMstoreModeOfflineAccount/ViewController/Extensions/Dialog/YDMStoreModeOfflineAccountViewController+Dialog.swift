//
//  YDMStoreModeOfflineAccountViewController+Dialog.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 15/01/21.
//

import UIKit

import YDB2WComponents

extension YDMStoreModeOfflineAccountViewController {
  func showAlert(title: String, message: String) {
    let dialog = YDDialog()
    dialog.delegate = self
    dialog.start(ofType: .simple)
  }
}

extension YDMStoreModeOfflineAccountViewController: YDDialogCoordinatorDelegate {
  func onActionYDDialog() {
    //
  }
}
