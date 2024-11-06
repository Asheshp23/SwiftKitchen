import SwiftUI
import SwiftData

struct AddRecipeView: View {
  @ObservedObject var viewModel: RecipeViewModel
  @State private var title = ""
  @State private var ingredients = ""
  @State private var instructions = ""
  @State private var selectedCategory: Category?
  @State private var showAddCategorySheet = false
  @State private var showAddCategoryAlert = false
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Recipe Details")) {
          TextField("Recipe Title", text: $title)
          TextEditor(text: $ingredients)
            .frame(height: 100)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
            )
            .overlay(
              Text("Ingredients")
                .foregroundColor(Color.secondary)
                .opacity(ingredients.isEmpty ? 1 : 0)
                .padding(.leading, 4),
              alignment: .topLeading
            )
          TextEditor(text: $instructions)
            .frame(height: 100)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
            )
            .overlay(
              Text("Instructions")
                .foregroundColor(Color.secondary)
                .opacity(instructions.isEmpty ? 1 : 0)
                .padding(.leading, 4),
              alignment: .topLeading
            )
        }
        
        Section(header: Text("Category")) {
          Picker("Category", selection: $selectedCategory) {
            Text("Select a category").tag(nil as Category?)
            ForEach(viewModel.categories) { category in
              Text(category.name).tag(category as Category?)
            }
          }
          
          Button("Add New Category") {
            showAddCategorySheet = true
          }
        }
      }
      .navigationTitle("Add Recipe")
      .navigationBarItems(
        leading: Button("Cancel") { dismiss() },
        trailing: Button("Save") {
          saveRecipe()
        }
          .disabled(title.isEmpty || ingredients.isEmpty || instructions.isEmpty || selectedCategory == nil)
      )
      .sheet(isPresented: $showAddCategorySheet) {
        AddCategoryView(viewModel: viewModel)
      }
      .alert(isPresented: $showAddCategoryAlert) {
        Alert(
          title: Text("Category Required"),
          message: Text("Please select or add a category for your recipe."),
          dismissButton: .default(Text("OK"))
        )
      }
    }
  }
  
  private func saveRecipe() {
    guard let category = selectedCategory else {
      showAddCategoryAlert = true
      return
    }
    
    viewModel.addRecipe(
      title: title,
      ingredients: ingredients,
      instructions: instructions,
      category: category,
      context: modelContext
    )
    dismiss()
  }
}

struct AddCategoryView: View {
  @ObservedObject var viewModel: RecipeViewModel
  @State private var categoryName = ""
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    NavigationView {
      Form {
        TextField("Category Name", text: $categoryName)
      }
      .navigationTitle("Add Category")
      .navigationBarItems(
        leading: Button("Cancel") { dismiss() },
        trailing: Button("Save") {
          viewModel.addCategory(name: categoryName, context: modelContext)
          dismiss()
        }
          .disabled(categoryName.isEmpty)
      )
    }
  }
}
