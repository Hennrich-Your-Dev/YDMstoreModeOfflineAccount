//
//  TermsViewController+ScrollView.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 03/02/21.
//

import UIKit

extension TermsViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
      // reach bottom
      if !shadowScrollEnabled {
        shadowScrollEnabled = true
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.shadowContainerView.layer.applyShadow()
          self?.separatorView.layer.opacity = 0
        }
      }
    }

    if (scrollView.contentOffset.y < 0) {
      //reach top
      UIView.animate(withDuration: 0.5) { [weak self] in
        self?.shadowContainerView.layer.shadowOpacity = 0
        self?.separatorView.layer.opacity = 1

        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { _ in
          self?.shadowScrollEnabled = false
        }
      }
    }

    if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)) {
      // not top and not bottom
      if !shadowScrollEnabled {
        shadowScrollEnabled = true
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.shadowContainerView.layer.applyShadow()
          self?.separatorView.layer.opacity = 0
        }
      }
    }
  }
}
