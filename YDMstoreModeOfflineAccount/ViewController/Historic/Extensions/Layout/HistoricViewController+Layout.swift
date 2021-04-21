//
//  HistoricViewController+Layout.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 23/02/21.
//

import UIKit

import YDExtensions

extension HistoricViewController {
  func buildList() {
    guard let list = viewModel?.historicList.value else { return }

    for (index, curr) in list.enumerated() {
      let vw = UIStackView()
      vw.axis = .vertical
      vw.alignment = .center
      vw.distribution = .fill
      vw.spacing = 0
      stackView.addArrangedSubview(vw)

      vw.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        vw.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
        vw.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16)
      ])

      if index == 0 {
        let spaceView = UIView()
        spaceView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        vw.addArrangedSubview(spaceView)
      }

      // Date
      if curr.formattedDate != nil {
        buildDateContainer(parent: vw, withData: curr)
      }

      // Origin
      buildOriginContainer(parent: vw, withData: curr)

      // Datas
      buildDatasContainer(parent: vw, withData: curr)

      // Objective
      buildObjectiveContainer(parent: vw, withData: curr)

      // Separator
      if index != list.count - 1 {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        vw.addArrangedSubview(separatorView)

        NSLayoutConstraint.activate([
          separatorView.heightAnchor.constraint(equalToConstant: 1),
          separatorView.leadingAnchor.constraint(equalTo: vw.leadingAnchor),
          separatorView.trailingAnchor.constraint(equalTo: vw.trailingAnchor)
        ])

        //
      } else {
        let spaceView = UIView()
        spaceView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        vw.addArrangedSubview(spaceView)
      }
    }
  }

  func buildDateContainer(
    parent vw: UIStackView,
    withData data: HistoricData
  ) {
    let dateContainer = UIView()
    dateContainer.layer.cornerRadius = 12
    dateContainer.layer.applyShadow()
    dateContainer.backgroundColor = .white
    vw.addArrangedSubview(dateContainer)
    vw.setCustomSpacing(25, after: dateContainer)

    dateContainer.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dateContainer.centerXAnchor.constraint(equalTo: vw.centerXAnchor),
      dateContainer.heightAnchor.constraint(equalToConstant: 24)
    ])

    let dateLabel = UILabel()
    dateLabel.text = data.formattedDate
    dateLabel.font = .systemFont(ofSize: 14)
    dateLabel.textColor = UIColor.Zeplin.black
    dateLabel.textAlignment = .center
    dateContainer.addSubview(dateLabel)

    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dateLabel.leadingAnchor.constraint(equalTo: dateContainer.leadingAnchor, constant: 43),
      dateLabel.trailingAnchor.constraint(equalTo: dateContainer.trailingAnchor, constant: -43),
      dateLabel.centerYAnchor.constraint(equalTo: dateContainer.centerYAnchor)
    ])
  }

  func buildOriginContainer(
    parent vw: UIStackView,
    withData data: HistoricData
  ) {
    let originLabelDescription = UILabel()
    originLabelDescription.textColor = UIColor.Zeplin.grayLight
    originLabelDescription.font = .systemFont(ofSize: 14)
    originLabelDescription.textAlignment = .left
    originLabelDescription.text = "origem"
    vw.addArrangedSubview(originLabelDescription)
    vw.setCustomSpacing(4, after: originLabelDescription)

    NSLayoutConstraint.activate([
      originLabelDescription.leadingAnchor.constraint(equalTo: vw.leadingAnchor),
      originLabelDescription.heightAnchor.constraint(equalToConstant: 24),
    ])

    let originLabel = UILabel()
    originLabel.textColor = UIColor.Zeplin.black
    originLabel.font = .systemFont(ofSize: 16)
    originLabel.textAlignment = .left
    originLabel.text = data.origin
    originLabel.numberOfLines = 2
    vw.addArrangedSubview(originLabel)
    vw.setCustomSpacing(20, after: originLabel)

    NSLayoutConstraint.activate([
      originLabel.leadingAnchor.constraint(equalTo: vw.leadingAnchor),
      originLabel.trailingAnchor.constraint(equalTo: vw.trailingAnchor)
    ])
  }

  func buildDatasContainer(
    parent vw: UIStackView,
    withData data: HistoricData
  ) {
    let datasLabelDescription = UILabel()
    datasLabelDescription.textColor = UIColor.Zeplin.grayLight
    datasLabelDescription.font = .systemFont(ofSize: 14)
    datasLabelDescription.textAlignment = .left
    datasLabelDescription.text = "dados informados"
    vw.addArrangedSubview(datasLabelDescription)
    vw.setCustomSpacing(4, after: datasLabelDescription)

    NSLayoutConstraint.activate([
      datasLabelDescription.leadingAnchor.constraint(equalTo: vw.leadingAnchor),
      datasLabelDescription.heightAnchor.constraint(equalToConstant: 24),
    ])

    let infos = data.getHistoricDataSet()

    for (index, curr) in infos.enumerated() {
      let view = UIView()
      vw.addArrangedSubview(view)

      if index == 0 {
        vw.setCustomSpacing(0, after: view)
      }

      view.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        view.leadingAnchor.constraint(equalTo: vw.leadingAnchor),
        view.trailingAnchor.constraint(equalTo: vw.trailingAnchor),
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
      ])

      let titleLabel = UILabel()
      titleLabel.textAlignment = .left
      titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
      titleLabel.text = "\(curr.title):"
      titleLabel.textColor = UIColor.Zeplin.black
      view.addSubview(titleLabel)

      titleLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 2)
      ])
      titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

      let valueLabel = UILabel()
      valueLabel.textAlignment = .left
      valueLabel.font = .systemFont(ofSize: 16)
      valueLabel.text = "\(curr.value)"
      valueLabel.textColor = UIColor.Zeplin.black
      valueLabel.numberOfLines = 2
      view.addSubview(valueLabel)

      valueLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
        valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        valueLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 2),
        valueLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2)
      ])
      valueLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
      valueLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

      if index == infos.count - 1 {
        vw.setCustomSpacing(20, after: view)
      }
    }
  }

  func buildObjectiveContainer(
    parent vw: UIStackView,
    withData data: HistoricData
  ) {
    let objectiveLabelDescription = UILabel()
    objectiveLabelDescription.textColor = UIColor.Zeplin.grayLight
    objectiveLabelDescription.font = .systemFont(ofSize: 14)
    objectiveLabelDescription.textAlignment = .left
    objectiveLabelDescription.text = "objetivo"
    vw.addArrangedSubview(objectiveLabelDescription)
    vw.setCustomSpacing(4, after: objectiveLabelDescription)

    NSLayoutConstraint.activate([
      objectiveLabelDescription.leadingAnchor.constraint(equalTo: vw.leadingAnchor),
      objectiveLabelDescription.heightAnchor.constraint(equalToConstant: 24),
    ])

    let objectiveLabel = UILabel()
    objectiveLabel.textColor = UIColor.Zeplin.black
    objectiveLabel.font = .systemFont(ofSize: 16)
    objectiveLabel.textAlignment = .left
    objectiveLabel.text = data.objective
    objectiveLabel.numberOfLines = 2
    vw.addArrangedSubview(objectiveLabel)
    vw.setCustomSpacing(20, after: objectiveLabel)

    NSLayoutConstraint.activate([
      objectiveLabel.leadingAnchor.constraint(equalTo: vw.leadingAnchor),
      objectiveLabel.trailingAnchor.constraint(equalTo: vw.trailingAnchor)
    ])
  }
}
