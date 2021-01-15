//
//  UserDataViewController.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 14/01/21.
//

import UIKit
import Hero

import YDB2WAssets

class UserDataViewController: UIViewController {
  // MARK: Properties

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
      tableView.tableFooterView = UIView()
    }
  }
  
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
}
