//
//  HistoricData.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 08/02/21.
//

import Foundation

class HistoricData: Codable {
  let origin: String
  let objective: String
  let date: String?
  let fields: HistoricDataFields

  var formattedDate: String {
    guard let date = date else { return "--/--/----" }
    let toFormat = "DD/MM/yyyy"
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-DD'T'HH:mm:ss"
    return formatter.date(from: date)?.toFormat(toFormat) ?? "--/--/----"
  }

  var dateWithDateType: Date? {
    guard let date = date else { return nil }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-DD'T'HH:mm:ss"

    return formatter.date(from: date)
  }

  func getHistoricDataSet() -> [HistoricDataSet] {
    var data: [HistoricDataSet] = []

    if let socialSecurity = fields.socialSecurity,
       !socialSecurity.isEmpty,
       let formatedSocialSecurity = DataSet.formatSocialSecurityNumber(socialSecurity) {
      let titleName = formatedSocialSecurity.count == 14 ? "cpf" : "cnpj"
      data.append(HistoricDataSet(title: titleName, value: formatedSocialSecurity))
    }

    if let name = fields.name,
       !name.isEmpty {
      data.append(HistoricDataSet(title: "nome", value: name))
    }

    if let email = fields.email,
       !email.isEmpty {
      data.append(HistoricDataSet(title: "e-mail", value: email))
    }

    if let cell = fields.cellPhone,
       !cell.isEmpty {
      let phoneData = HistoricDataSet(title: "telefone celular",
                                  value: DataSet.formatPhoneNumber(cell) ?? "")

      data.append(phoneData)
    }

    if let home = fields.homePhone,
       !home.isEmpty {
      let phoneData = HistoricDataSet(title: "telefone residencial",
                                      value: DataSet.formatPhoneNumber(home) ?? "")

      data.append(phoneData)
    }

    if let address = fields.address,
       !address.isEmpty {
      data.append(HistoricDataSet(title: "endereço", value: address))
    }

    if let relationship = fields.relationship,
       !relationship.isEmpty {
      data.append(HistoricDataSet(title: "estado civil", value: relationship))
    }

    return data.compactMap { $0 }
  }

  enum CodingKeys: String, CodingKey {
    case date = "data_atualizacao"
    case origin = "origem"
    case objective = "finalidade"
    case fields = "campos"
  }
}

class HistoricDataFields: Codable {
  let socialSecurity: String?
  let name: String?
  let email: String?
  let homePhone: String?
  let cellPhone: String?
  let address: String?
  let relationship: String?

  enum CodingKeys: String, CodingKey {
    case socialSecurity = "CPF_CNPJ"
    case name = "Nome"
    case email = "Email"
    case homePhone = "Telefone_residencial"
    case cellPhone = "Telefone_celular"
    case address = "Endereco"
    case relationship = "Estado_civil"
  }
}

struct HistoricDataSet: Codable {
  let title: String
  let value: String
}
