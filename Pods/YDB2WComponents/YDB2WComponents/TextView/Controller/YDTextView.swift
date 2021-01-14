//
//  YDTextView.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 18/11/20.
//

import UIKit
import YDExtensions

public protocol YDTextViewDelegate {
  func textViewDidChangeSelection(_ textView: UITextView)
  func shouldChangeText(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
  func onNextButtonYDTextView(_ value: String?)
}

public class YDTextView: UIView {
  // MARK: Properties
  public var placeHolder: String = "" {
    didSet {
      textView.text = placeHolder
    }
  }
  public var defaultTextColor: UIColor? = UIColor(hex: "#666666")
  public var delegate: YDTextViewDelegate?
  let messageTextViewMaxHeight: CGFloat = 69

  // MARK: IBOutlets
  @IBOutlet var contentView: UIView!

  @IBOutlet weak var textView: UITextView! {
    didSet {
      textView.backgroundColor = .clear

      textView.layer.borderWidth = 1
      textView.layer.borderColor = UIColor(hex: "#999999")?.cgColor
      textView.layer.cornerRadius = 8

      textView.delegate = self

      textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//      textView.addButtonNext(target: self, action: #selector(onNextButton))
    }
  }

  @IBOutlet var heightConstraint: NSLayoutConstraint! {
    didSet {
      heightConstraint.isActive = false
    }
  }

  // MARK: Init
  init() {
    let rect = CGRect(
      x: 0,
      y: 0,
      width: UIWindow.keyWindow?.frame.width ?? 0,
      height: 35
    )

    super.init(frame: rect)
    instanceXib()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    instanceXib()
  }

  // MARK: Actions
  func instanceXib() {
    contentView = loadNib()
    addSubview(contentView)

    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: self.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])

    backgroundColor = .clear
    contentView.backgroundColor = .clear

    textView.textColor = .lightGray
  }

  @objc func onNextButton() {
    textView.resignFirstResponder()
    delegate?.onNextButtonYDTextView(textView.text == placeHolder ? nil : textView.text)
  }
}

extension YDTextView: UITextViewDelegate {
  public func textViewDidChangeSelection(_ textView: UITextView) {
    delegate?.textViewDidChangeSelection(textView)

    if textView.contentSize.height >= messageTextViewMaxHeight {
      textView.isScrollEnabled = true

      if heightConstraint != nil {
        heightConstraint.isActive = true
        layoutIfNeeded()
      }

    } else {
      textView.frame.size.height = textView.contentSize.height
      textView.isScrollEnabled = false

      if heightConstraint != nil {
        heightConstraint.isActive = false
        layoutIfNeeded()
      }
    }
  }

  public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if delegate != nil {
      return delegate?.shouldChangeText(textView, shouldChangeTextIn: range, replacementText: text) ?? false
    }

    return true
  }

  public func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .lightGray {
      textView.text = nil
      textView.textColor = defaultTextColor
    }
  }

  public func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = placeHolder
      textView.textColor = UIColor.lightGray
    }
  }
}
