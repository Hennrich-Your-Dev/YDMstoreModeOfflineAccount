//
//  UserDataViewController+TableView.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 25/01/21.
//

import UIKit

// MARK: Actions
extension UserDataViewController {
  func dequeueCellConstructor(at indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
      case 0:
        return dequeueUsersInfoCell(at: indexPath)

      case 1:
        return dequeueMarketingSwitchCell(at: indexPath)

      case 2:
        return dequeueTermsSwitchCell(at: indexPath)

      default:
        return UITableViewCell()
    }
  }

  func dequeueUsersInfoCell(at indexPath: IndexPath) -> UITableViewCell {
    guard let viewModel = viewModel,
          let cell = tableView.dequeueReusableCell(
            withIdentifier: UserDataTableViewCell.identifier,
            for: indexPath) as? UserDataTableViewCell,
          let info = viewModel[indexPath.row] else {
      return UITableViewCell()
    }

    cell.config(with: info)
    return cell
  }

  func dequeueMarketingSwitchCell(at indexPath: IndexPath) -> UITableViewCell {
    guard let viewModel = viewModel,
          let userInfo = viewModel.userData,
          let cell = tableView.dequeueReusableCell(
            withIdentifier: UserDataMarketingTableViewCell.identifier,
            for: indexPath) as? UserDataMarketingTableViewCell
    else {
      return UITableViewCell()
    }

    cell.config(withValue: userInfo.marketing) { value in
      //
      viewModel.userData?.marketing = value
    }
    return cell
  }

  func dequeueTermsSwitchCell(at indexPath: IndexPath) -> UITableViewCell {
    guard let viewModel = viewModel,
          let userInfo = viewModel.userData,
          let cell = tableView.dequeueReusableCell(
            withIdentifier: UserDataTermsAndButtonTableViewCell.identifier,
            for: indexPath) as? UserDataTermsAndButtonTableViewCell
    else {
      return UITableViewCell()
    }

    cell.config(withValue: userInfo.terms) { value in
      //
      viewModel.userData?.terms = value
    }
    return cell
  }
}

// MARK: TableView Data Source
extension UserDataViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      // Para criar a celula especial com 2 dados
      return viewModel?.usersInfo.value.count ?? 0
    }

    return 1
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    return dequeueCellConstructor(at: indexPath)
  }
}

// MARK: TableView Delegate
extension UserDataViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0 {
      return 66
    }

    return 20
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section == 0 {
      let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: UserDataHeaderView.identifier) as? UserDataHeaderView

      header?.config(with: "25/01/2021", onAction: {
        print("inside action callback")
      })

      return header
    } else {
      let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
      headerView.backgroundColor = .white

      let separator = UIView()
      separator.backgroundColor = .black
      separator.layer.opacity = 0.1
      headerView.addSubview(separator)

      separator.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        separator.heightAnchor.constraint(equalToConstant: 1),
        separator.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 21),
        separator.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -21),
        separator.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 1)
      ])

      headerView.layoutIfNeeded()

      return headerView
    }
  }
}
