//
//  YDIntegrationConfigFeature.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

public struct YDConfigFeature {
  public init(name: String, extras: [String : Any]?) {
    self.name = name
    self.extras = extras
  }

  public let name: String
  public let extras: [String: Any]?
}
