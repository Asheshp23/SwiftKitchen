//
//  RecipeDetailView.swift
//  SwiftKitchen
//
//  Created by Ashesh Patel on 2024-11-05.
//
import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(recipe.title)
                .font(.largeTitle)
                .bold()
            
            Text("Category: \(recipe.category?.name ?? "None")")
                .font(.subheadline)
            
            Text("Ingredients")
                .font(.headline)
            Text(recipe.ingredients)
            
            Text("Instructions")
                .font(.headline)
            Text(recipe.instructions)
            
            Spacer()
        }
        .padding()
        .navigationTitle(recipe.title)
    }
}
