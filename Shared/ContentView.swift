//
//  ContentView.swift
//  Shared
//
//  Created by Mitch on 2/14/22.
//

// 77 1/2 tall
// left side 58
// right side 50

import SwiftUI
import CoreData
import web3swift
import BigInt

struct ContentView: View {
    
    //@StateObject var convalent = Covalent()
    @State private var showPopUp: Bool = false
    
    @StateObject private var web3 = BaseWeb3(provider: .Mainnet)
    
    @State private var showToolSilder : Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Account.address, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Account>
    
    var body: some View {
  
        ZStack{
            NavigationView {
                List {
                    ForEach(items, id:\.self) { item in
                        CovalentView(name: item.name!, address: item.address!)
                    }.onDelete(perform: deleteItems)
                }
                .navigationBarTitle(Text("Wallets"))

                // Toolbar set up
                .toolbar {
#if os(iOS)
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
#endif
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
            
            PopUpWindow(showPopUp: $showPopUp, web: web3)

        }
    }
    
    
    
    private func addItem() {
        withAnimation {
            showPopUp.toggle()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        
        withAnimation {
            //convalent.accounts.remove(atOffsets: offsets)
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
     
    // END of content view
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)
    }
}
