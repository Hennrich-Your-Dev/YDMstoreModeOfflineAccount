//
//  HistoricViewController+Layouts.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 05/05/21.
//

import UIKit

import YDB2WAssets

extension HistoricViewController {
  func configureLayout() {
    title = "minhas ações nas lojas físicas"

    configureErrorView()
    createBackButton()
  }

  func createBackButton() {
    let backButtonView = UIButton()
    backButtonView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
    backButtonView.layer.cornerRadius = 16
    backButtonView.layer.applyShadow()
    backButtonView.backgroundColor = .white
    backButtonView.setImage(Icons.leftArrow, for: .normal)
    backButtonView.addTarget(self, action: #selector(onBackAction), for: .touchUpInside)

    let backButton = UIBarButtonItem()
    backButton.customView = backButtonView

    navigationItem.leftBarButtonItem = backButton
  }

  func configureErrorView() {
    view.addSubview(errorView)
    errorView.isHidden = true

    NSLayoutConstraint.activate([
      errorView.topAnchor.constraint(equalTo: view.topAnchor),
      errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    errorView.callback = { [weak self] _ in
      guard let self = self else { return }
      self.viewModel?.getHistoricList()

      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.errorView.isHidden = true
      }
    }
  }
}
