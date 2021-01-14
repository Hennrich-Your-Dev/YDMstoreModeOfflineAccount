//
//  YDUserProfileView.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 14/01/21.
//

import UIKit

import YDExtensions
import YDUtilities

public class YDUserProfileView: UIView {
  // MARK: IBOutlets
  @IBOutlet var contentView: UIView!
  
  @IBOutlet weak var photoImageView: UIImageView! {
    didSet {
      photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
    }
  }

  @IBOutlet weak var nameLabel: UILabel!
  
  // MARK: Init
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  private func commonInit() {
    contentView = loadNib()
    addSubview(contentView)

    contentView.translatesAutoresizingMaskIntoConstraints = false

    let top = contentView.topAnchor.constraint(equalTo: self.topAnchor)
    let bottom = contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    let leading = contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
    let trailing = contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)

    NSLayoutConstraint.activate([top, bottom, leading, trailing])
  }

  // MARK: Config
  public func config(username: String, userPhoto: UIImage?) {
    nameLabel.text = username

    if let photo = userPhoto {
      photoImageView.image = photo
    } else {
      photoImageView.image = GenerateImageFromLetter.withName(
        username,
        backgroundColor: UIColor.Zeplin.grayOpaque,
        textColor: UIColor.Zeplin.grayLight,
        textFont: UIFont.systemFont(ofSize: 28)
      )
    }
  }
}
