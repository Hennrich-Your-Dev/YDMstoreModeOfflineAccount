//
//  TermsViewController.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 02/02/21.
//

import UIKit

import YDB2WAssets
import YDExtensions
import YDSpacey

class TermsViewController: UIViewController, UITextViewDelegate {
  // MARK: Properties
  var viewModel: TermsViewModelDelegate?
  var navBarShadowOff = true

  // MARK: Components
  var spaceyComponent: YDSpaceyViewController?

  // MARK: IBOutlets
  @IBOutlet weak var shadowContainerView: UIView! {
    didSet {
      shadowContainerView.backgroundColor = .white
    }
  }

  @IBOutlet weak var separatorView: UIView!

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "política de privacidade"

    createBackButton()
    configureSpaceyComponent()

    spaceyComponent?.getSpacey(withId: "politica-de-privacidade")
  }
}

// MARK: Actions
extension TermsViewController {
  func createBackButton() {
    let backButtonView = UIButton()
    backButtonView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
    backButtonView.layer.cornerRadius = 16
    backButtonView.layer.applyShadow()
    backButtonView.backgroundColor = .white
    backButtonView.setImage(Icons.leftArrow, for: .normal)
    backButtonView.addTarget(self, action: #selector(onBackAction), for: .touchUpInside)

    let backButton = UIBarButtonItem()
    backButton.customView = backButtonView

    navigationItem.leftBarButtonItem = backButton
  }

  @objc func onBackAction(_ sender: UIButton) {
    viewModel?.onBack()
  }

  func toggleNavShadow(_ show: Bool) {
    if show {
      UIView.animate(withDuration: 0.5) { [weak self] in
        self?.shadowContainerView.layer.applyShadow()
        self?.separatorView.layer.opacity = 0
      }
    } else {
      UIView.animate(withDuration: 0.5) { [weak self] in
        self?.shadowContainerView.layer.shadowOpacity = 0
        self?.separatorView.layer.opacity = 1
      }
    }
  }
}

// MARK: UI
extension TermsViewController {
  func configureSpaceyComponent() {
    let vc = YDSpacey().start(supportedTypes: [.termsOfUse])
    addChild(vc)
    spaceyComponent = vc
    spaceyComponent?.delegate = self

    vc.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      vc.view.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
      vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      vc.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
