//
//  HistoricViewController+ScrollView.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 03/02/21.
//

import UIKit

import YDExtensions

// MARK: Actions
extension HistoricViewController {
  func buildList() {
    guard let list = viewModel?.historicList.value else { return }

    for (index, curr) in list.enumerated() {
      let vw = UIView()
      vw.frame = CGRect(x: 0, y: 0, width: stackView.frame.size.width, height: 250)
      stackView.addArrangedSubview(vw)

      vw.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        vw.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
        vw.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16)
      ])

      // Date
      let dateContainer = buildDateContainer(view: vw, withData: curr)
      vw.addSubview(dateContainer)
    }
  }

  func buildDateContainer(view vw: UIView, withData data: HistoricData) -> UIView {
    let dateContainer = UIView()
    dateContainer.frame = CGRect(x: 0, y: 0, width: 100, height: 24)
    dateContainer.layer.cornerRadius = 12
    dateContainer.layer.applyShadow()
    dateContainer.backgroundColor = .white

    dateContainer.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dateContainer.centerYAnchor.constraint(equalTo: vw.centerYAnchor),
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

    return dateContainer
  }
}

extension HistoricViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
      // reach bottom
      if !shadowScrollEnabled {
        shadowScrollEnabled = true
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.shadowContainerView.layer.applyShadow()
          self?.separatorView.layer.opacity = 0
        }
      }
    }

    if (scrollView.contentOffset.y < 0) {
      //reach top
      UIView.animate(withDuration: 0.5) { [weak self] in
        self?.shadowContainerView.layer.shadowOpacity = 0
        self?.separatorView.layer.opacity = 1

        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { _ in
          self?.shadowScrollEnabled = false
        }
      }
    }

    if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)) {
      // not top and not bottom
      if !shadowScrollEnabled {
        shadowScrollEnabled = true
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.shadowContainerView.layer.applyShadow()
          self?.separatorView.layer.opacity = 0
        }
      }
    }
  }
}
