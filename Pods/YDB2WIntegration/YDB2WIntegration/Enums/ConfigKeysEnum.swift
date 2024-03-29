//
//  ConfigKeysEnum.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

public enum YDConfigKeys: String {
  case store = "ydevO2O"
  case live = "ydevLive"

  case restQL = "restQLService"
  case chatService = "userChatService"
  case productService = "catalog_service"
  case storeService = "store_service"
  case spaceyService = "spacey_service"
  case addressService = "zip_code_service"
  case lasaClientService = "lasaCustomerPortal"
  case invoiceService = "offlineOrdersNoteService"
  case googleService = "youtubeStatisticsApi"
  case neowayService = "neowayService"
  case customerSupportService = "customer_support_service"
}

public enum YDConfigProperty: String {
  // Search stores
  case maxStoreRange = "acheUmaLojaFeatureNearbyStores"
  case insideLasaDistance = "distanceUserLasaStore"

  // Store Mode
  case productsQueryVersion = "lasaB2WProductsQueryVersion"
  case offlineAccountEnabled

  // Store Mode NPS
  case npsEnabled
  case npsFeedbackMessage
  case npsMinutesToPrune
  case npsSpaceyId

  // Live
  case liveSpaceyOrder = "spaceyPositionIndex"

  case liveCarrouselProductsBatches = "lazyLoadingItems"

  case liveYouTubePlayerAutoStart
  case liveYouTubePlayerResetVideoWhenPaused
  case liveYouTubePlayerEnableFullScreenButton

  case preLiveHotsite
  case liveStartTimeMinusMinutes
  case checkForLiveTimerConfig
  case liveHotsiteId = "liveHotsite"
  case liveChatEnabled = "chatEnabled"

  case liveChatLikesEnabled = "chatLikesEnabled"
  case liveChatLikesSpeed = "liveChatLikeSpeed"

  case liveChatPolling
  case liveChatPollingError
  case liveChatLimit
  case liveChatSendDelay
  case liveChatModerators = "chatModerators"
  case liveHighlightMessageEnabled = "fixedMessageEnabled"

  case liveYouTubeCounter = "liveAmountPeopleWatching"
  case liveAmountPeopleWatchingPolling

  case liveNPSEnabled
  case liveNPSLiveIdEnabled
  
  case afterLiveEnabled
  case afterLiveHotsite
  case afterLivePollingTimeInSeconds = "afterLivePollingTime"

  // Next Lives
  case nextLiveEnabled
  case nextLiveSpaceyId = "nextLiveHotsite"
  case nextLivesReminderTimeInMinutes = "nextLivesReminderTime"

  // Google Services
  case youtubeKey

  // Lasa Client
  case lazyLoadingOrders

  // Offline Orders
  case offlineOrdersNoteEnabled = "enableOfflineOrdersNote"
  
  // Miscellaneous
  case secret
  case urlPrivacyPolicy = "url_privacy_policy"
}
