//
//  HistoricViewController+TableView.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 03/02/21.
//

import UIKit

// MARK: Actions
extension HistoricViewController {}

// MARK: TableView Data Source
extension HistoricViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.historicList.value.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: HistoricTableViewCell.identifier,
      for: indexPath
    ) as? HistoricTableViewCell,
    let currentHistoricData = viewModel?[indexPath.row]
    else {
      return UITableViewCell()
    }

    cell.config(with: currentHistoricData)

    return cell
  }
}

// MARK: TableView Delegate
extension HistoricViewController: UITableViewDelegate {}
