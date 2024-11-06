//
//  Category.swift
//  SwiftKitchen
//
//  Created by Ashesh Patel on 2024-11-05.
//
import Foundation
import SwiftData

@Model
class Category {
  @Attribute(.unique) var id: UUID
  var name: String
  
  init(id: UUID = UUID(), name: String) {
    self.id = id
    self.name = name
  }
}
