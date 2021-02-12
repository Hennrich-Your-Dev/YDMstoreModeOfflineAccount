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
//      contentView.clipsToBounds = true
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

  @IBOutlet weak var scrollView: UIScrollView! {
    didSet {
      scrollView.delegate = self
    }
  }

  @IBOutlet weak var stackView: UIStackView!

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.hero.isEnabled = true
    view.hero.id = "background"

    setViewBackgroundImage()
    setBinds()
    viewModel?.getHistoricList()
  }

  // MARK: IBActions
  @IBAction func onBackButton(_ sender: Any) {
    viewModel?.onBack()
  }

  @IBAction func onExportAction(_ sender: Any) {
    if let image = snapshot() {
      let activityViewController = UIActivityViewController(
        activityItems: [image],
        applicationActivities: nil
      )

      present(activityViewController, animated: true, completion: nil)
    }
  }

}

// MARK: Actions
extension HistoricViewController {
  func setViewBackgroundImage() {
    if let image = Images.map {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }

  func snapshot() -> UIImage? {
    let holeScreenSize = CGSize(
      width: contentView.frame.size.width,
      height: (contentView.frame.size.height - scrollView.frame.height) + scrollView.contentSize.height
    )

    let savedViewFrame = view.frame
    let savedContentFrame = contentView.frame
    let savedTableFrame = scrollView.frame
    let savedContentOffset = scrollView.contentOffset

    defer {
      UIGraphicsEndImageContext()

      view.frame = savedViewFrame
      contentView.frame = savedContentFrame
      scrollView.contentOffset = savedContentOffset
      scrollView.frame = savedTableFrame
      backButton.isHidden = false
      exportButton.isHidden = false

      shadowScrollEnabled = false
    }

    scrollView.contentOffset = CGPoint(x: 0, y: -20)
    shadowScrollEnabled = true
    separatorView.layer.opacity = 1
    shadowContainerView.layer.shadowOpacity = 0

    view.frame = CGRect(
      x: 0,
      y: 0,
      width: contentView.frame.size.width,
      height: holeScreenSize.height
    )

    contentView.frame = CGRect(
      x: 0,
      y: 0,
      width: contentView.frame.size.width,
      height: holeScreenSize.height
    )

    scrollView.frame = CGRect(
      x: 0,
      y: 20,
      width: scrollView.contentSize.width,
      height: scrollView.contentSize.height
    )

    scrollView.showsVerticalScrollIndicator = false

    backButton.isHidden = true
    exportButton.isHidden = true

    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(holeScreenSize, false, scale)

    guard let context = UIGraphicsGetCurrentContext() else { return nil }

    contentView.layer.render(in: context)

    let image = UIGraphicsGetImageFromCurrentImageContext()
    return image
  }
}
