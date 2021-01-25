//
//  UserDataSet.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 25/01/21.
//

import Foundation

struct UserDataSet {
  let title: String
  let value: String

  static func formatDate(_ date: String, toFormat: String = "DD/MM/YYYY") -> String? {
    let dateFormatterGet = ISO8601DateFormatter()
    dateFormatterGet.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

    return dateFormatterGet.date(from: date)?.toFormat(toFormat)
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

    data.append(UserDataSet(title: "nome", value: name ?? ""))
    data.append(UserDataSet(title: "cpf", value: socialSecurity ?? ""))

    if let dateString = birthday {
      data.append(
        UserDataSet(
          title: "data de nascimento",
          value: UserDataSet.formatDate(dateString) ?? ""
        )
      )
    } else {
      data.append(UserDataSet(title: "data de nascimento", value: ""))
    }

    data.append(UserDataSet(title: "sexo", value: gender ?? ""))
    data.append(UserDataSet(title: "estado civil", value: relationship ?? ""))
    data.append(UserDataSet(title: "e-mail", value: email ?? ""))
    data.append(UserDataSet(title: "telefone celular", value: cellPhone ?? ""))
    data.append(UserDataSet(title: "telefone residencial", value: homePhone ?? ""))

    return data
  }
}
