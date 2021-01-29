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
import YDB2WComponents

class YDMStoreModeOfflineAccountViewController: UIViewController {
  // MARK: Properties
  var viewModel: YDMStoreModeOfflineAccountViewModelDelegate?
  var navBarShadowOff = true
  
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
  
  @IBOutlet weak var scrollView: UIScrollView! {
    didSet {
      scrollView.delegate = self
    }
  }
  
  @IBOutlet weak var stackView: UIStackView!

  @IBOutlet weak var userProfileView: YDUserProfileView!

  @IBOutlet weak var qrCardContainer: UIView! {
    didSet {
      qrCardContainer.layer.cornerRadius = 8
      qrCardContainer.layer.applyShadow(blur: 20)
      qrCardContainer.tag = 0

      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCardAction))
      qrCardContainer.addGestureRecognizer(tapGesture)
    }
  }

  @IBOutlet weak var qrImageView: UIImageView! {
    didSet {
      qrImageView.image = Images.qrCode
    }
  }

  @IBOutlet weak var clipboardContainer: UIView! {
    didSet {
      clipboardContainer.layer.cornerRadius = 8
      clipboardContainer.layer.applyShadow(blur: 20)
      clipboardContainer.tag = 1

      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCardAction))
      clipboardContainer.addGestureRecognizer(tapGesture)
    }
  }
  
  @IBOutlet weak var clipboardImageView: UIImageView! {
    didSet {
      clipboardImageView.image = Images.clipboard
    }
  }

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    stackView.setCustomSpacing(31, after: userProfileView)
    
    setViewBackgroundImage()
    setBinds()

    viewModel?.trackState()
    userProfileView.config(username: "Douglas Hennrich", userPhoto: nil)
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

  @objc func onCardAction(_ sender: UIGestureRecognizer) {
    guard let tag = sender.view?.tag else {
      return
    }

    //
    viewModel?.onCard(tag: tag)
  }
}
