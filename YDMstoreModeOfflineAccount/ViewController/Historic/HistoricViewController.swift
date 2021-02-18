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
  var navBarShadowOff = true

  // MARK: IBOutlets
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

    title = "minhas ações nas lojas físicas"

    createBackButton()
    setBinds()
    viewModel?.getHistoricList()
  }

  // MARK: IBActions
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

  func snapshot() -> UIImage? {
    let holeScreenSize = CGSize(
      width: view.frame.size.width,
      height: (view.frame.size.height - scrollView.frame.height) + scrollView.contentSize.height
    )

    let savedViewFrame = view.frame
    let savedTableFrame = scrollView.frame
    let savedContentOffset = scrollView.contentOffset

    defer {
      UIGraphicsEndImageContext()

      view.frame = savedViewFrame
      scrollView.contentOffset = savedContentOffset
      scrollView.frame = savedTableFrame
      navigationItem.setHidesBackButton(false, animated: true)
      exportButton.isHidden = false

      navBarShadowOff = true
    }

    scrollView.contentOffset = CGPoint(x: 0, y: -20)
    navBarShadowOff = false
    separatorView.layer.opacity = 1
    shadowContainerView.layer.shadowOpacity = 0

    view.frame = CGRect(
      x: 0,
      y: 0,
      width: view.frame.size.width,
      height: holeScreenSize.height
    )

    scrollView.frame = CGRect(
      x: 0,
      y: 20,
      width: scrollView.contentSize.width,
      height: scrollView.contentSize.height
    )

    scrollView.showsVerticalScrollIndicator = false

    navigationItem.setHidesBackButton(true, animated: true)
    exportButton.isHidden = true

    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(holeScreenSize, false, scale)

    guard let context = UIGraphicsGetCurrentContext() else { return nil }

    navigationController?.view.layer.render(in: context)

    let image = UIGraphicsGetImageFromCurrentImageContext()
    return image
  }
}
