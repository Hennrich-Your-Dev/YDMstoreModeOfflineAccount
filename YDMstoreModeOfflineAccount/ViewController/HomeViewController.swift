//
//  HomeViewController.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 17/02/21.
//

import UIKit

class PreHomeViewController: UIViewController {
  // MARK: Properties
  var viewModel: PreHomeViewModelDelegate?

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpLayout()
  }
}
