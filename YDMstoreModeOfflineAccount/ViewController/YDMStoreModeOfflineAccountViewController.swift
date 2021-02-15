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
    
    setViewBackgroundImage()
    setBinds()
    buildCards()

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

  func buildCards() {
    stackView.setCustomSpacing(31, after: userProfileView)

    let cards: [[String: Any]] = [
      [
        "icon": Images.qrCode as Any,
        "title": "vai se identificar no caixa das lojas físicas?",
        "button": "acesse aqui!"
      ],
      [
        "icon": Images.clipboard as Any,
        "title": "tudo que sabemos sobre você está aqui :)",
        "button": "confere aqui!"
      ]
    ]

    for (index, curr) in cards.enumerated() {
      let card = UIView()
      card.backgroundColor = .white
      card.layer.cornerRadius = 8
      card.layer.applyShadow(blur: 20)
      card.tag = index

      card.addGestureRecognizer(
        UITapGestureRecognizer(target: self,
                               action: #selector(onCardAction))
      )

      stackView.addArrangedSubview(card)

      NSLayoutConstraint.activate([
        card.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 24),
        card.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -24),
        card.heightAnchor.constraint(equalToConstant: 138)
      ])
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
