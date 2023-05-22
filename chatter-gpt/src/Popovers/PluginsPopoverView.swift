
import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    var keywords: String
    var prompt: String
    var usesAppData: Bool
    var endpoint: String
    var isEnabled: Bool
}

struct PluginsPopoverView: View {
    @State var items: [Item] = []
    @State var isEditing = false
    
    let popover: NSPopover
    
    init(popover: NSPopover) {
        self.popover = popover
    }
    
    var body: some View {
        List {
            ForEach(items) { item in
                HStack {
                    TextField("Keywords", text: $items[getIndex(item)].keywords)
                    TextField("Prompt", text: $items[getIndex(item)].prompt)
                    Toggle("Uses App Data", isOn: $items[getIndex(item)].usesAppData)
                    TextField("Endpoint", text: $items[getIndex(item)].endpoint)
                    Button(action: { removeItem(item) }) {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                    }
                }
                .disabled(!item.isEnabled)
            }
            .onDelete(perform: delete)
        }
        .toolbar {
            ToolbarItemGroup {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
                Button(action: {
                    isEditing.toggle()
                }) {
                    Label(isEditing ? "Done" : "Edit", systemImage: isEditing ? "checkmark.circle.fill" : "pencil")
                }
            }
        }
        .navigationTitle("Items")
        .listStyle(.plain)
    }

    func addItem() {
        items.append(Item(keywords: "", prompt: "", usesAppData: false, endpoint: "", isEnabled: true))
    }

    func removeItem(_ item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }

    func getIndex(_ item: Item) -> Int {
        return items.firstIndex(where: { $0.id == item.id }) ?? 0
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
