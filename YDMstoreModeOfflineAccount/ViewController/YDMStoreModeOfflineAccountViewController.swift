//
//  YDMStoreModeOfflineAccountViewController.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas on 12/01/21.
//

import UIKit
import Hero

import YDB2WAssets
import YDExtensions

class YDMStoreModeOfflineAccountViewController: UIViewController {
  // MARK: Properties
  var viewModel: YDMStoreModeOfflineAccountViewModelDelegate?
  
  // MARK: IBOutlets
  @IBOutlet weak var contentView: UIView! {
    didSet {
      contentView.layer.cornerRadius = 16
      contentView.hero.id = "bottomSheet"
    }
  }
  
  @IBOutlet weak var navContainer: UIView! {
    didSet {
      navContainer.backgroundColor = .clear
    }
  }
  
  @IBOutlet weak var backButton: UIButton! {
    didSet {
      backButton.layer.cornerRadius = backButton.frame.height / 2
      backButton.setImage(Icons.leftArrow, for: .normal)
      backButton.layer.applyShadow()
    }
  }
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setViewBackgroundImage()
  }
  
  // MARK: IBActions
  @IBAction func onBackAction(_ sender: UIButton) {
    viewModel?.onExit()
  }
}

// MARK: Actions
extension YDMStoreModeOfflineAccountViewController {
  func setViewBackgroundImage() {
    if let image = Images.map {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
}
