//
//  UsersInfo.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 27/01/21.
//

import Foundation

class UsersInfo: Codable {
  let name: String?
  var socialSecurity: String?
  let gender: String?
  let relationship: String?
  let birthday: String?
  let email: String?
  let cellPhone: String?
  let homePhone: String?
  let date: String?

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
    case date = "data_atualizacao"
  }

  // MARK: Actions
  func getUserDataSets() -> [DataSet] {
    var data: [DataSet] = []

    if let name = name,
       !name.isEmpty {
      data.append(DataSet(title: "nome", value: name))
    }

    if let socialSecurity = socialSecurity,
       !socialSecurity.isEmpty,
       let formatedSocialSecurity = DataSet.formatSocialSecurityNumber(socialSecurity) {
      data.append(DataSet(title: "cpf", value: formatedSocialSecurity))
    }

    if let dateString = birthday,
       !dateString.isEmpty,
       let formatedDate = DataSet.formatDate(dateString) {
      data.append(
        DataSet(
          title: "data de nascimento",
          value: formatedDate
        )
      )
    }

    if let gender = gender,
       !gender.isEmpty {
      data.append(DataSet(title: "sexo", value: gender))
    }

    if let relationship = relationship,
       !relationship.isEmpty {
      data.append(DataSet(title: "estado civil", value: relationship))
    }

    if let email = email,
       !email.isEmpty {
      data.append(DataSet(title: "e-mail", value: email))
    }

    if let cell = cellPhone,
       !cell.isEmpty {
      var phoneData = DataSet(title: "telefone celular",
                                  value: DataSet.formatPhoneNumber(cell))

      if let home = homePhone,
         !home.isEmpty {
        phoneData.doubleTitle = "telefone residencial"
        phoneData.doubleValue = DataSet.formatPhoneNumber(home)
      }

      data.append(phoneData)
    }

    data.append(DataSet(type: .separator, title: "", value: nil))

    data.append(DataSet(type: .marketing, title: "", value: nil))

    data.append(DataSet(type: .separator, title: "", value: nil))

    data.append(DataSet(type: .termsAndSave, title: "", value: nil))

    return data
  }
}
