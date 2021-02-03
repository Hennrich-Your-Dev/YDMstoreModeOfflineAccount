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
  var shadowScrollEnabled = false

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

  @IBOutlet weak var lastUpdateLabelTitle: UILabel!

  @IBOutlet weak var lastUpdateLabel: UILabel!

  @IBOutlet weak var historicButton: UIButton!

  @IBOutlet weak var tableView: UITableView!  {
    didSet {
      tableView.dataSource = self
      tableView.tableFooterView = UIView()

      let bundle = Bundle.init(for: UserDataViewController.self)

      // Users Info
      tableView.register(
        UserDataInfoTableViewCell.loadNib(bundle),
        forCellReuseIdentifier: UserDataInfoTableViewCell.identifier
      )

      // Separator
      tableView.register(
        UserDataSeparatorTableViewCell.loadNib(bundle),
        forCellReuseIdentifier: UserDataSeparatorTableViewCell.identifier
      )

      // Marketing Switcher
      tableView.register(
        UserDataMarketingTableViewCell.loadNib(bundle),
        forCellReuseIdentifier: UserDataMarketingTableViewCell.identifier
      )

      // Terms Switcher & Save Button
      tableView.register(
        UserDataTermsAndButtonTableViewCell.loadNib(bundle),
        forCellReuseIdentifier: UserDataTermsAndButtonTableViewCell.identifier
      )
    }
  }

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  @IBOutlet weak var shadowContainerView: UIView! {
    didSet {
      shadowContainerView.backgroundColor = .white
      shadowContainerView.layer.zPosition = 5
    }
  }

  @IBOutlet weak var separatorView: UIView! {
    didSet {
      separatorView.layer.zPosition = 6
    }
  }

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.hero.isEnabled = true
    view.hero.id = "background"
    setViewBackgroundImage()

    setBinds()

    viewModel?.trackState()
    viewModel?.getUsersInfo()

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(onTermsNotification),
      name: NSNotification.Name("openTerms"),
      object: nil
    )
  }

  // MARK: IBActions
  @IBAction func onBackAction(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }

  @IBAction func onHistoricAction(_ sender: Any) {
    viewModel?.openHistoric()
  }

  // MARK: Actions
  func setViewBackgroundImage() {
    if let image = Images.map {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }

  @objc func onTermsNotification() {
    viewModel?.openTerms()
  }
}
