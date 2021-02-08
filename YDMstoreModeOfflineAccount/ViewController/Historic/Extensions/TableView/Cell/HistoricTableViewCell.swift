//
//  HistoricTableViewCell.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 04/02/21.
//

import UIKit

import YDExtensions

class HistoricTableViewCell: UITableViewCell {
  // MARK: Properties
  @IBOutlet weak var dateContainer: UIView! {
    didSet {
      dateContainer.layer.cornerRadius = 24
      dateContainer.layer.applyShadow()
      dateContainer.backgroundColor = .white
    }
  }

  @IBOutlet weak var dateLabel: UILabel!

  @IBOutlet weak var originLabel: UILabel!

  @IBOutlet weak var stackView: UIStackView!

  @IBOutlet weak var goalLabel: UILabel!

  // MARK: IBOutlets
  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = .white
  }

  // MARK: Config
  func config(with config: HistoricData) {
    dateLabel.text = config.formattedDate
    originLabel.text = config.origin
    goalLabel.text = config.objective

    buildDatas(from: config.data)
  }

  private func buildDatas(from data: [HistoricDataSet]) {
    for curr in data {
      let view = UIView(
        frame: CGRect(
          x: 0,
          y: 0,
          width: stackView.frame.size.width,
          height: 20
        )
      )

      let titleLabel = UILabel()
      titleLabel.textAlignment = .left
      titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
      titleLabel.text = "\(curr.title):"
      titleLabel.textColor = UIColor.Zeplin.black
      view.addSubview(titleLabel)

      NSLayoutConstraint.activate([
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])

      let valueLabel = UILabel()
      valueLabel.textAlignment = .left
      valueLabel.font = .systemFont(ofSize: 16)
      valueLabel.text = "\(curr.value)"
      valueLabel.textColor = UIColor.Zeplin.black
      valueLabel.numberOfLines = 1
      view.addSubview(valueLabel)

      NSLayoutConstraint.activate([
        valueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        valueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        valueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])

      stackView.addArrangedSubview(view)
    }
  }
}
