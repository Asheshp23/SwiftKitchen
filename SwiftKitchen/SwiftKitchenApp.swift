//
//  SwiftKitchenApp.swift
//  SwiftKitchen
//
//  Created by Ashesh Patel on 2024-11-05.
//

import SwiftUI
import SwiftData

@main
struct SwiftKitchenApp: App {
  let container: ModelContainer
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(container)
    }
  }
  
  init() {
    let schema = Schema([Recipe.self])
    let config = ModelConfiguration("MyRecipes", schema: schema)
    do {
      container = try ModelContainer(for: schema, configurations: config)
    } catch {
      fatalError("Could not configure the container")
    }
    //        let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBooks.store"))
    //        do {
    //            container = try ModelContainer(for: Book.self, configurations: config)
    //        } catch {
    //            fatalError("Could not configure the container")
    //        }
    print(URL.applicationSupportDirectory.path(percentEncoded: false))
    //        print(URL.documentsDirectory.path())
  }
}
