//
//  Recipe.swift
//  SwiftKitchen
//
//  Created by Ashesh Patel on 2024-11-05.
//
import Foundation
import SwiftData

@Model
class Recipe {
  @Attribute(.unique)
  var id: UUID = UUID()
  var title: String
  var ingredients: String
  var instructions: String
  var dateAdded: Date
  @Relationship(deleteRule: .cascade)
  var category: Category?
  
  init(id: UUID = UUID(), title: String, ingredients: String, instructions: String, category: Category? = nil) {
    self.id = id
    self.title = title
    self.ingredients = ingredients
    self.instructions = instructions
    self.dateAdded = Date()
    self.category = category
  }
}
