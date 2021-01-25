//
//  UserDataHeaderView.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 25/01/21.
//

import UIKit

class UserDataHeaderView: UITableViewHeaderFooterView {
  // MARK: Properties
  var callback: (() -> Void)?

  // MARK: IBOutlets
  @IBOutlet weak var lastUpdateLabel: UILabel!

  // MARK: Config
  func config(with date: String, onAction action: (() -> Void)?) {
    contentView.backgroundColor = .white
    lastUpdateLabel.text = date
    callback = action
  }

  // MARK: IBActions
  @IBAction func onHistoricButtonAction(_ sender: UIButton) {
    callback?()
  }
}
