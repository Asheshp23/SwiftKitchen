//
//  RecipeViewModel.swift
//  SwiftKitchen
//
//  Created by Ashesh Patel on 2024-11-05.
//
import SwiftUI
import SwiftData

@MainActor
class RecipeViewModel: ObservableObject {
  @Published var recipes: [Recipe] = []
  @Published var categories: [Category] = []
  
  func addRecipe(title: String, ingredients: String, instructions: String, category: Category, context: ModelContext) {
    let recipe = Recipe(title: title, ingredients: ingredients, instructions: instructions, category: category)
    context.insert(recipe)
    fetchRecipes(context: context)
  }
  
  func fetchRecipes(context: ModelContext) {
    do {
      let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.title)])
      recipes = try context.fetch(descriptor)
    } catch {
      print("Error fetching recipes: \(error)")
    }
  }
  
  func deleteRecipe(_ recipe: Recipe, context: ModelContext) {
    context.delete(recipe)
    fetchRecipes(context: context)
  }
  
  func addCategory(name: String, context: ModelContext) {
    let category = Category(name: name)
    context.insert(category)
    fetchCategories(context: context)
  }
  
  @MainActor
  func fetchCategories(context: ModelContext) {
    do {
      let descriptor = FetchDescriptor<Category>(sortBy: [SortDescriptor(\.name)])
      categories = try context.fetch(descriptor)
    } catch {
      print("Error fetching categories: \(error)")
    }
  }
}
