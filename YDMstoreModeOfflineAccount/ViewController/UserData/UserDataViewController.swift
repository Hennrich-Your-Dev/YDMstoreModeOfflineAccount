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
  var viewModel: UserDataViewModelDelegate?
  var items: [Int] = []

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
      tableView.delegate = self
      tableView.dataSource = self
      tableView.tableFooterView = UIView()

      let bundle = Bundle.init(for: UserDataViewController.self)

      tableView.register(
        UserDataHeaderView.loadNib(bundle),
        forHeaderFooterViewReuseIdentifier: UserDataHeaderView.identifier
      )

      tableView.register(
        UserDataTableViewCell.loadNib(bundle),
        forCellReuseIdentifier: UserDataTableViewCell.identifier
      )
    }
  }

  @IBOutlet weak var headerDateLabel: UILabel!

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.hero.isEnabled = true
    view.hero.id = "background"

    setViewBackgroundImage()

    setBinds()

    viewModel?.getUsersInfo()
  }

  // MARK: IBActions
  @IBAction func onBackAction(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }

  func setViewBackgroundImage() {
    if let image = Images.map {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
}
