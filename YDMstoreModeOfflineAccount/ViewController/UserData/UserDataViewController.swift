//
//  UserDataViewController.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 14/01/21.
//

import UIKit
import Hero

import YDB2WAssets
import YDExtensions

class UserDataViewController: UIViewController {
  // MARK: Properties
  var items = [1, 2, 3]

  // MARK: IBOutlets
  @IBOutlet weak var contentView: UIView! {
    didSet {
      contentView.layer.cornerRadius = 16
      contentView.hero.id = "bottomSheet"
    }
  }

  @IBOutlet weak var navContainer: UIView! {
    didSet {
      navContainer.backgroundColor = .white
    }
  }

  @IBOutlet weak var backButton: UIButton! {
    didSet {
      backButton.layer.cornerRadius = backButton.frame.height / 2
      backButton.setImage(Icons.leftArrow, for: .normal)
      backButton.layer.applyShadow()
    }
  }

  @IBOutlet weak var tableView: UITableView!  {
    didSet {
      tableView.dataSource = self
      tableView.tableFooterView = UIView()

      let bundle = Bundle.init(for: Self.self)
      tableView.register(
        UserDataHeaderView.loadNib(bundle),
        forHeaderFooterViewReuseIdentifier: UserDataHeaderView.identifier
      )
    }
  }
  
  @IBOutlet weak var headerDateLabel: UILabel!

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    view.hero.isEnabled = true
    // Do any additional setup after loading the view.
  }

  // MARK: IBActions
  @IBAction func onBackAction(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }

  @IBAction func onHistoricButtonAction(_ sender: UIButton) {
  }
}

// MARK: TableView Data Source
extension UserDataViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
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
