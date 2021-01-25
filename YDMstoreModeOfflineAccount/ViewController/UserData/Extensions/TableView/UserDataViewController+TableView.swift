//
//  UserDataViewController+TableView.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 25/01/21.
//

import UIKit

// MARK: TableView Data Source
extension UserDataViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let count = viewModel?.usersInfo.value.count
    else {
      return 0
    }

    // Para criar a celula especial com 2 dados
    return count - 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let viewModel = viewModel,
          let cell = tableView.dequeueReusableCell(
            withIdentifier: UserDataTableViewCell.identifier,
            for: indexPath) as? UserDataTableViewCell,
          let info = viewModel[indexPath.row] else {
      return UITableViewCell()
    }

    if indexPath.row == viewModel.usersInfo.value.count - 1,
       let lastInfo = viewModel[indexPath.row + 1] {
      cell.config(with: [info, lastInfo])
    } else {
      cell.config(with: info)
    }

    return cell
  }
}

// MARK: TableView Delegate
extension UserDataViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: UserDataHeaderView.identifier) as? UserDataHeaderView

    header?.config(with: "25/01/2021", onAction: {
      print("inside action callback")
    })

    return header
  }
}
