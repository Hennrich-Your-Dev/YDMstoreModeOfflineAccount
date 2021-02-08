//
//  HistoricViewController.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 02/02/21.
//

import UIKit
import Hero

import YDB2WAssets
import YDExtensions

class HistoricViewController: UIViewController {
  // MARK: Properties
  var viewModel: HistoricViewModelDelegate?
  var shadowScrollEnabled = false

  // MARK: IBOutlets
  @IBOutlet weak var contentView: UIView! {
    didSet {
      contentView.layer.cornerRadius = 16
      contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      contentView.clipsToBounds = true
      contentView.hero.id = "bottomSheet"
    }
  }

  @IBOutlet weak var navContainer: UIView!  {
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

  @IBOutlet weak var exportButton: UIButton! {
    didSet {
      exportButton.layer.cornerRadius = 6
      exportButton.layer.borderWidth = 1
      exportButton.layer.borderColor = UIColor.Zeplin.redBranding.cgColor
    }
  }

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

  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self

      tableView.tableFooterView = UIView()

      let bundle = Bundle(for: Self.self)

      tableView.register(
        HistoricTableViewCell.loadNib(bundle),
        forCellReuseIdentifier: HistoricTableViewCell.identifier
      )
    }
  }

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.hero.isEnabled = true
    view.hero.id = "background"

    setViewBackgroundImage()
    setBinds()
  }

  // MARK: IBActions
  @IBAction func onBackButton(_ sender: Any) {
    viewModel?.onBack()
  }

  @IBAction func onExportAction(_ sender: Any) {
    
  }

}

// MARK: Actions
extension HistoricViewController {
  func setViewBackgroundImage() {
    if let image = Images.map {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
}
