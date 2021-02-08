//
//  UserDataSet.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 25/01/21.
//

import Foundation

import YDExtensions

enum UserDataSetTypeEnum {
  case info
  case separator
  case marketing
  case termsAndSave
}

struct UserDataSet {
  var type: UserDataSetTypeEnum = .info
  let title: String
  let value: String?
  var doubleTitle: String? = nil
  var doubleValue: String? = nil

  // MARK: Actions
  static func formatDate(_ date: String, toFormat: String = "dd/MM/yyyy") -> String? {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

    return dateFormatterGet.date(from: date)?.toFormat(toFormat)
  }

  static func formatPhoneNumber(_ number: String?) -> String? {
    guard let numberUnwarp = number else { return nil }

    let cleanNumber = numberUnwarp.replacingOccurrences(
      of: "[^0-9]",
      with: "",
      options: .regularExpression
    )

    switch cleanNumber.count {
      case 11:
        return cleanNumber.applyPatternOnNumbers(pattern: "(##) #####-####", replacmentCharacter: "#")

      case 10:
        return cleanNumber.applyPatternOnNumbers(pattern: "(##) ####-####", replacmentCharacter: "#")

      case 9:
        return cleanNumber.applyPatternOnNumbers(pattern: "#####-####", replacmentCharacter: "#")

      case 8:
        return cleanNumber.applyPatternOnNumbers(pattern: "####-####", replacmentCharacter: "#")

      default:
        return number
    }
  }

  static func formatSocialSecurityNumber(_ number: String?, toFormat: String = "###.###.###-##") -> String? {
    return number?.applyPatternOnNumbers(pattern: toFormat, replacmentCharacter: "#")
  }
}
