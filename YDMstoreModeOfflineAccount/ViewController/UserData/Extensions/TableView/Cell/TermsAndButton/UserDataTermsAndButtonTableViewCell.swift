//
//  UserDataTermsAndButtonTableViewCell.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 27/01/21.
//

import UIKit

import YDExtensions

class UserDataTermsAndButtonTableViewCell: UITableViewCell {
  // MARK: Properties
  var callback: ((Bool) -> Void)?
  let tapGesture = UITapGestureRecognizer(
    target: self,
    action: #selector(onTermsTap)
  )

  // MARK: IBOutlets
  @IBOutlet weak var termsSwitch: UISwitch!

  @IBOutlet weak var termsLabel: UILabel! {
    didSet {
      let termsText = "Li e concordo com os Termos e condições e Política de privacidade."
      let toUnderline = "Termos e condições e Política de privacidade."

      let attributedString = NSMutableAttributedString(string: termsText)

      guard let range = termsText.range(of: toUnderline) else {
        return
      }

      let index = termsText.distance(from: termsText.startIndex, to: range.lowerBound)
      let location = NSRange(location: index, length: toUnderline.count)

      attributedString.addAttribute(
        NSAttributedString.Key.underlineStyle,
        value: NSUnderlineStyle.single.rawValue,
        range: location
      )

      attributedString.addAttribute(
        NSAttributedString.Key.foregroundColor,
        value: UIColor.Zeplin.colorPrimaryLight,
        range: location
      )

      termsLabel.attributedText = attributedString
      layoutIfNeeded()
    }
  }

  @IBOutlet weak var saveButton: UIButton! {
    didSet {
      saveButton.layer.borderWidth = 1
      saveButton.layer.borderColor = UIColor.Zeplin.colorPrimaryLight.cgColor
      saveButton.layer.cornerRadius = 6

      saveButton.setTitleColor(UIColor.Zeplin.black, for: .disabled)
    }
  }

  // MARK: Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    termsSwitch.setOn(false, animated: false)
    saveButton.isEnabled = false
    callback = nil

    termsLabel.removeGestureRecognizer(tapGesture)
  }

  // MARK: Config
  func config(withValue switchValue: Bool, onAction action: @escaping ((Bool) -> Void)) {
    termsSwitch.setOn(switchValue, animated: true)
    onSwitchChange()
    callback = action

    termsLabel.addGestureRecognizer(tapGesture)
  }

  // MARK: IBActions
  @IBAction func onButtonAction(_ sender: Any) {
    callback?(termsSwitch.isOn)
  }

  @IBAction func onSwitchChange(_ sender: Any? = nil) {
    saveButton.isEnabled = termsSwitch.isOn
    saveButton.backgroundColor = termsSwitch.isOn ? .clear : UIColor.Zeplin.grayDisabled
    saveButton.layer.borderColor = termsSwitch.isOn ?
      UIColor.Zeplin.colorPrimaryLight.cgColor : UIColor.Zeplin.grayDisabled.cgColor
  }

  // MARK:
  @objc func onTermsTap() {
    NotificationCenter.default.post(
      name: NSNotification.Name("openTerms"),
      object: nil
    )
  }
}
