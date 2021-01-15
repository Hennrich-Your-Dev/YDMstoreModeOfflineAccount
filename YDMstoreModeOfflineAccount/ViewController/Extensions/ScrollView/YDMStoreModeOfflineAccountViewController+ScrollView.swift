//
//  YDMStoreModeOfflineAccountViewController+ScrollView.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 14/01/21.
//

import UIKit

extension YDMStoreModeOfflineAccountViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
      // reach bottom
//      UIView.animate(withDuration: 0.5) { [weak self] in
//        self?.welcomeContainer.layer.applyShadow()
//      }
    }

    if (scrollView.contentOffset.y < 0){
      //reach top
      UIView.animate(withDuration: 0.5) { [weak self] in
        self?.navContainer.layer.shadowOpacity = 0

        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
          self?.navBarShadowOff = true
        }
      }
    }

    if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
      // not top and not bottom
      if navBarShadowOff {
        navBarShadowOff = false
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.navContainer.layer.applyShadow(y: 2)
        }
      }
    }
  }
}
