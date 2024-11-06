//
//  RecipeListView.swift
//  SwiftKitchen
//
//  Created by Ashesh Patel on 2024-11-05.
//
import SwiftUI

struct RecipeListView: View {
  @StateObject private var viewModel = RecipeViewModel()
  @State private var searchText = ""
  @State private var selectedCategory: Category?
  @Environment(\.modelContext) private var context
  
  var body: some View {
    NavigationView {
      VStack {
        // Category Filter Picker
        Picker("Filter by Category", selection: $selectedCategory) {
          Text("All").tag(Category?.none)
          ForEach(viewModel.categories) { category in
            Text(category.name).tag(category as Category?)
          }
        }
        .pickerStyle(MenuPickerStyle())
        
        // Search Bar
        TextField("Search Recipes", text: $searchText)
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(8)
          .padding(.horizontal)
        
        // Recipe List
        List {
          if viewModel.recipes.isEmpty {
            VStack {
              Text("No Recipes Found")
              Spacer()
            }
          } else {
            ForEach(viewModel.recipes.filter {
              (searchText.isEmpty || $0.title.contains(searchText)) &&
              (selectedCategory == nil || $0.category == selectedCategory)
            }) { recipe in
              NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                Text(recipe.title)
              }
            }
            .onDelete { indexSet in
              for index in indexSet {
                let recipe = viewModel.recipes[index]
                viewModel.deleteRecipe(recipe, context: context)
              }
            }
          }
        }
        .navigationTitle("SwiftBites")
        .toolbar {
          ToolbarItem(placement: .primaryAction) {
            NavigationLink("Add Recipe", destination: AddRecipeView(viewModel: viewModel))
          }
        }
      }
      .onAppear {
        viewModel.fetchRecipes(context: context)
      }
    }
  }
}
