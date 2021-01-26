//
//  UserDataViewController+Binds.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 25/01/21.
//

import Foundation

extension UserDataViewController {
  func setBinds() {
//    viewModel?.error.bind { [weak self] params in
//      //
//    }

    viewModel?.loading.bind { [weak self] isLoading in
      if isLoading {
        self?.activityIndicator.isHidden = false
        self?.activityIndicator.startAnimating()
      } else {
        self?.activityIndicator.isHidden = true
      }
    }

    viewModel?.usersInfo.bind { [weak self] _ in
      self?.tableView.reloadData()
    }
  }
}
