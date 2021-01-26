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

class UsersInfo: Decodable {
  let name: String?
  var socialSecurity: String?
  let gender: String?
  let relationship: String?
  let birthday: String?
  let email: String?
  let cellPhone: String?
  let homePhone: String?

  var marketing: Bool = false
  var terms: Bool = false

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case name = "nome_completo"
    case socialSecurity = "cpf"
    case gender = "sexo"
    case relationship = "estado_civil"
    case birthday = "data_nascimento"
    case email
    case cellPhone = "telefone_celular"
    case homePhone = "telefone_residencial"
    case marketing = "optin_marketing"
    case terms = "optin_termos_condicoes"
  }

  // MARK: Actions
  func getUserDataSets() -> [UserDataSet] {
    var data: [UserDataSet] = []

    if let name = name {
      data.append(UserDataSet(title: "nome", value: name))
    }

    if let socialSecurity = socialSecurity {
      data.append(UserDataSet(title: "cpf", value: socialSecurity))
    }

    if let dateString = birthday,
       let formatedDate = UserDataSet.formatDate(dateString) {
      data.append(
        UserDataSet(
          title: "data de nascimento",
          value: formatedDate
        )
      )
    }

    if let gender = gender {
      data.append(UserDataSet(title: "sexo", value: gender))
    }

    if let relationship = relationship {
      data.append(UserDataSet(title: "estado civil", value: relationship))
    }

    if let email = email {
      data.append(UserDataSet(title: "e-mail", value: email))
    }

    if let cell = cellPhone {
      var phoneData = UserDataSet(title: "telefone celular",
                                  value: UserDataSet.formatPhoneNumber(cell))

      if let home = homePhone {
        phoneData.doubleTitle = "telefone residencial"
        phoneData.doubleValue = UserDataSet.formatPhoneNumber(home)
      }

      data.append(phoneData)
    }

    return data
  }
}
