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
  let data: [HistoricDataSet]
  let date: String

  var formattedDate: String? {
    let toFormat = "DD/MM/yyyy"
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-DD'T'HH:mm:ss"
    return formatter.date(from: date)?.toFormat(toFormat)
  }

  enum CodingKeys: String, CodingKey {
    case date = "data"
    case origin = "origem"
    case objective = "finalidade"
    case data = "campos"
  }
}

class HistoricDataSet: Codable {
  let title: String
  let value: String

  required init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()

    self.title = try container.decode(String.self)
    self.value = self.title
  }
}
