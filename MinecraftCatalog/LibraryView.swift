import SwiftUI

struct LibraryView: View {
    @State private var search = ""
    @State private var selected = "全部"
    @State private var visibleItems = Catalog.items

    var body: some View {
        NavigationStack {
            List {
                CatalogHero()
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                InventoryFilters(search: $search, selected: $selected)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)

                Section {
                    ForEach(visibleItems) { item in
                        NavigationLink(value: item) {
                            InventoryRow(item: item)
                        }
                        .listRowBackground(MinecraftTheme.panel)
                        .listRowSeparatorTint(MinecraftTheme.muted.opacity(0.3))
                    }
                    if visibleItems.isEmpty {
                        ContentUnavailableView("背包裡沒有這個物品", systemImage: "shippingbox",
                                               description: Text("試試其他中文、英文名稱或分類。"))
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                } header: {
                    InventoryListHeader(count: visibleItems.count)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .minecraftScreen()
            .navigationTitle("物品圖鑑")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: MinecraftItem.self) { ItemDetailView(item: $0) }
            .onChange(of: search) { updateItems() }
            .onChange(of: selected) { updateItems() }
        }
    }

    private func updateItems() {
        visibleItems = Catalog.items.filter { item in
            (selected == "全部" || item.category == selected)
                && (search.isEmpty || item.name.localizedCaseInsensitiveContains(search)
                    || item.englishName.localizedCaseInsensitiveContains(search))
        }
    }
}

private struct InventoryFilters: View {
    @Binding var search: String
    @Binding var selected: String

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass").foregroundStyle(MinecraftTheme.green)
                TextField("搜尋中文或英文名稱", text: $search)
                    .font(.subheadline)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                if !search.isEmpty {
                    Button { search = "" } label: {
                        Image(systemName: "xmark").frame(width: 44, height: 44)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("清除搜尋")
                }
            }
            .padding(.horizontal, 14)
            .frame(minHeight: 52)
            .blockPanel(MinecraftTheme.ink)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(["全部"] + Catalog.categories, id: \.self) { category in
                        Button { selected = category } label: {
                            Text(category).font(.subheadline.bold())
                                .padding(.horizontal, 16).frame(minHeight: 46)
                        }
                        .buttonStyle(BlockButtonStyle(selected: selected == category))
                        .accessibilityAddTraits(selected == category ? .isSelected : [])
                    }
                }
            }
        }
    }
}

private struct InventoryListHeader: View {
    let count: Int

    var body: some View {
        HStack {
            Label("背包物品", systemImage: "list.bullet").font(.headline)
            Spacer()
            Text("\(count) 個物品")
                .font(.system(.caption, design: .monospaced))
                .foregroundStyle(MinecraftTheme.muted)
        }
        .foregroundStyle(MinecraftTheme.green)
        .textCase(nil)
        .padding(.vertical, 8)
    }
}

private struct InventoryRow: View {
    let item: MinecraftItem

    var body: some View {
        HStack(spacing: 14) {
            ItemSlot(item: item)
            VStack(alignment: .leading, spacing: 6) {
                Text(item.name).font(.headline).foregroundStyle(.white)
                Text(item.englishName)
                    .font(.system(.caption, design: .monospaced))
                    .foregroundStyle(MinecraftTheme.muted)
                Text(item.category).font(.caption.bold())
                    .foregroundStyle(MinecraftTheme.color(for: item.category))
            }
            .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
        .padding(.vertical, 8)
    }
}
