//
//  ConfigKeysEnum.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

public enum YDConfigKeys: String {
  case scanner = "lasa_price_scanner"
  case store = "store_mode"
  case live = "live"
}

public enum YDConfigProperty: String {
  // Search stores
  case maxStoreRange
  case storesType
  case storesUrl
  case storeModeProducts

  // Search products
  case productsUrl
  case customerId

  // Search address
  case addressUrl

  // Store
  case storeNPSEnabled = "npsEnabled"
  case storeNPSFeedbackMessage = "npsFeedbackMessage"

  // Live
  case liveHotsiteUrl
  case liveProductsUrl

  case liveSpaceyOrder
  case liveChatPoolling
  case liveChatLimit
  case liveChatOffset
  case liveChatEnabled = "chatEnabled"

  case liveChatGetMessagesUrl = "b2wChatApiURl"
  case liveChatSendMessageUrl
  case liveChatLikeUrl
  case liveChatSendDelay

  case liveChatLikeButtonEnabled = "chatLikesEnabled"
}
