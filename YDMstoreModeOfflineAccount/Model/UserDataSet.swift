//
//  UserDataSet.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 25/01/21.
//

import Foundation

import YDExtensions

struct UserDataSet {
  let title: String
  let value: String?
  var doubleTitle: String? = nil
  var doubleValue: String? = nil

  // MARK: Actions
  static func formatDate(_ date: String, toFormat: String = "DD/MM/YYYY") -> String? {
    let dateFormatterGet = ISO8601DateFormatter()
    dateFormatterGet.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

    return dateFormatterGet.date(from: date)?.toFormat(toFormat)
  }

  static func formatPhoneNumber(_ number: String?, toFormat: String = "(##) #####-####") -> String? {
    return number?.applyPatternOnNumbers(pattern: toFormat, replacmentCharacter: "#")
  }
}
