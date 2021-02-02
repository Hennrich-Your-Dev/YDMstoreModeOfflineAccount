//
//  TermsViewController.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 02/02/21.
//

import UIKit
import Hero

import YDB2WAssets
import YDExtensions

class TermsViewController: UIViewController {
  // MARK: Properties
  var viewModel: TermsViewModelDelegate?

  // MARK: IBOutlets
  @IBOutlet weak var contentView: UIView! {
    didSet {
      contentView.layer.cornerRadius = 16
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

  @IBOutlet weak var textView: UITextView!

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.hero.isEnabled = true
    view.hero.id = "background"

    setViewBackgroundImage()
    loadHTML()
  }

  // MARK: IBActions
  @IBAction func onBackButton(_ sender: Any) {
    viewModel?.onBack()
  }
}

// MARK: Actions
extension TermsViewController {
  func setViewBackgroundImage() {
    if let image = Images.map {
      view.backgroundColor = UIColor(patternImage: image)
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

      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.lineSpacing = 3

      attributedString.addAttribute(
        NSAttributedString.Key.paragraphStyle,
        value: paragraphStyle,
        range: NSMakeRange(0, attributedString.length)
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
