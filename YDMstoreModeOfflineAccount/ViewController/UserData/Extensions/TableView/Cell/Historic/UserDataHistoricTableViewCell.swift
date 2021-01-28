//
//  UserDataHistoricTableViewCell.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 28/01/21.
//

import UIKit

class UserDataHistoricTableViewCell: UITableViewCell {
  // MARK: Properties
  var callback: (() -> Void)?

  // MARK: IBOutlets
  @IBOutlet weak var dateLabel: UILabel!

  // MARK: Lifie cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    callback = nil
    dateLabel.text = nil
  }

  // MARK: Config
  func config(with info: UserDataSet, onAction action: @escaping () -> Void) {
    callback = action

    dateLabel.text = info.value
  }

  // MARK: IBActions
  @IBAction func onAction(_ sender: Any) {
    callback?()
  }

}
