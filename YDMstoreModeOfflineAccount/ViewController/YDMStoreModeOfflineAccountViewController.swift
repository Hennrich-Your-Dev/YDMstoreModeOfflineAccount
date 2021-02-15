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
      //      [
      //        "icon": Images.qrCode as Any,
      //        "title": "vai se identificar no caixa das lojas físicas?",
      //        "button": "acesse aqui!",
      //        "id": 1
      //      ],
      [
        "icon": Images.clipboard as Any,
        "title": "tudo que sabemos sobre você está aqui :)",
        "button": "confere aqui!",
        "id": 2
      ],
      [
        "icon": Images.basket as Any,
        "title": "suas compras nas lojas físicas com nota fiscal",
        "button": "estão aqui :)",
        "id": 3
      ]
    ]

    for curr in cards {
      let card = UIView()
      card.backgroundColor = .white
      card.layer.cornerRadius = 8
      card.layer.applyShadow(blur: 20)
      card.tag = curr["id"] as? Int ?? 0

      card.addGestureRecognizer(
        UITapGestureRecognizer(target: self,
                               action: #selector(onCardAction))
      )

      stackView.addArrangedSubview(card)

      card.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        card.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 24),
        card.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -24),
        card.heightAnchor.constraint(equalToConstant: 138)
      ])

      // Icon
      let imageView = UIImageView()
      imageView.image = curr["icon"] as? UIImage
      card.addSubview(imageView)

      imageView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        imageView.widthAnchor.constraint(equalToConstant: 76),
        imageView.heightAnchor.constraint(equalToConstant: 76),
        imageView.centerYAnchor.constraint(equalTo: card.centerYAnchor),
        imageView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 36)
      ])

      // Title
      let titleLabel = UILabel()
      titleLabel.text = curr["title"] as? String
      titleLabel.textAlignment = .center
      titleLabel.textColor = UIColor.Zeplin.black
      titleLabel.font = .systemFont(ofSize: 16)
      titleLabel.numberOfLines = 2
      card.addSubview(titleLabel)

      titleLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
        titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -24),
        titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 36)
      ])

      // Button
      let buttonLabel = UILabel()
      buttonLabel.text = curr["button"] as? String
      buttonLabel.textAlignment = .center
      buttonLabel.textColor = UIColor.Zeplin.grayLight
      buttonLabel.font = .systemFont(ofSize: 16)
      buttonLabel.numberOfLines = 1
      card.addSubview(buttonLabel)

      buttonLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        buttonLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
        buttonLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
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
