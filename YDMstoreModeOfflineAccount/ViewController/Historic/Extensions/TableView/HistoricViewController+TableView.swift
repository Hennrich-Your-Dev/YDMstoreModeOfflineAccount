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
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}

// MARK: TableView Delegate
extension HistoricViewController: UITableViewDelegate {}
