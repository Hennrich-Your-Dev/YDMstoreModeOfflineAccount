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
  var callback: (() -> Void)?

  // MARK: IBOutlets
  @IBOutlet weak var termsSwitch: UISwitch!

  @IBOutlet weak var termsLabel: UILabel! {
    didSet {
      let termsText = "Li e concordo com os Termos e condições e Política de privacidade."
      let toUnderline = "Termos e condições e Política de privacidade."

      let attributedString = NSMutableAttributedString(string: termsText)

      guard let range = attributedString.string.range(of: toUnderline) else {
        return
      }

      attributedString.addAttribute(
        NSAttributedString.Key.underlineStyle,
        value: NSUnderlineStyle.single.rawValue,
        range: NSMakeRange(
          (range.lowerBound.utf16Offset(in: toUnderline)),
          (range.upperBound.utf16Offset(in: toUnderline))
        )
      )

      termsLabel.attributedText = attributedString
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
  }

  // MARK: Config
  func config(withValue switchValue: Bool, onAction action: @escaping (() -> Void)) {
    termsSwitch.setOn(switchValue, animated: true)
    onSwitchChange()
    callback = action
  }

  // MARK: IBActions
  @IBAction func onButtonAction(_ sender: Any) {
    callback?()
  }

  @IBAction func onSwitchChange(_ sender: Any? = nil) {
    saveButton.isEnabled = termsSwitch.isOn
    saveButton.backgroundColor = termsSwitch.isOn ? .clear : UIColor.Zeplin.grayDisabled
    saveButton.layer.borderColor = termsSwitch.isOn ?
      UIColor.Zeplin.colorPrimaryLight.cgColor : UIColor.Zeplin.grayDisabled.cgColor
  }
}
