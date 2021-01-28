//
//  UserLogin.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 27/01/21.
//

import Foundation

struct UserLogin: Decodable {
  let socialSecurity: String?
  let name: String?
  let email: String?
  let token: String?
  let idLasa: String?

  enum CodingKeys: String, CodingKey {
    case socialSecurity = "cpf"
    case name = "nome"
    case email
    case token
    case idLasa = "id_lasa"
  }
}
