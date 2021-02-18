//
//  TermsViewController.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 02/02/21.
//

import UIKit

import YDB2WAssets
import YDExtensions

class TermsViewController: UIViewController, UITextViewDelegate {
  // MARK: Properties
  var viewModel: TermsViewModelDelegate?
  var navBarShadowOff = true

  // MARK: IBOutlets
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

  @IBOutlet weak var textView: UITextView! {
    didSet {
      textView.delegate = self
    }
  }

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "política de privacidade"

    createBackButton()
    loadHTML()
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

  func loadHTML() {
    let bundle = Bundle(for: Self.self)
    guard let path = bundle.path(forResource: "termos-uso", ofType: "html")
    else {
      return
    }

    let url = URL(fileURLWithPath: path)
    guard let description = try? Data(contentsOf: url) else { return }

    do {
      let attributedString = try NSMutableAttributedString(
        data: description,
        options: [
          .documentType: NSAttributedString.DocumentType.html,
          .characterEncoding: String.Encoding.utf8.rawValue
        ],
        documentAttributes: nil
      )

      attributedString.addAttribute(
        NSAttributedString.Key.foregroundColor,
        value: UIColor.Zeplin.black,
        range: NSMakeRange(0, attributedString.length)
      )

      textView.attributedText = attributedString

    } catch {
      debugPrint(error.localizedDescription)
    }
  }
}
