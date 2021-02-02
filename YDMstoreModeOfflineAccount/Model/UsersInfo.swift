//
//  UsersInfo.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 27/01/21.
//

import Foundation

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

    if let name = name,
       !name.isEmpty {
      data.append(UserDataSet(title: "nome", value: name))
    }

    if let socialSecurity = socialSecurity,
       !socialSecurity.isEmpty,
       let formatedSocialSecurity = UserDataSet.formatSocialSecurityNumber(socialSecurity) {
      data.append(UserDataSet(title: "cpf", value: formatedSocialSecurity))
    }

    if let dateString = birthday,
       !dateString.isEmpty,
       let formatedDate = UserDataSet.formatDate(dateString) {
      data.append(
        UserDataSet(
          title: "data de nascimento",
          value: formatedDate
        )
      )
    }

    if let gender = gender,
       !gender.isEmpty {
      data.append(UserDataSet(title: "sexo", value: gender))
    }

    if let relationship = relationship,
       !relationship.isEmpty {
      data.append(UserDataSet(title: "estado civil", value: relationship))
    }

    if let email = email,
       !email.isEmpty {
      data.append(UserDataSet(title: "e-mail", value: email))
    }

    if let cell = cellPhone,
       !cell.isEmpty {
      var phoneData = UserDataSet(title: "telefone celular",
                                  value: UserDataSet.formatPhoneNumber(cell))

      if let home = homePhone,
         !home.isEmpty {
        phoneData.doubleTitle = "telefone residencial"
        phoneData.doubleValue = UserDataSet.formatPhoneNumber(home)
      }

      data.append(phoneData)
    }

    data.append(UserDataSet(type: .separator, title: "", value: nil))

    data.append(UserDataSet(type: .marketing, title: "", value: nil))

    data.append(UserDataSet(type: .separator, title: "", value: nil))

    data.append(UserDataSet(type: .termsAndSave, title: "", value: nil))

    return data
  }
}
