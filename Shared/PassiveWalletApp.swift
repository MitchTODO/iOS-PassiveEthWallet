//
//  PassiveWalletApp.swift
//  Shared
//
//  Created by Mitch on 2/14/22.
//

import SwiftUI

@main
struct PassiveWalletApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
