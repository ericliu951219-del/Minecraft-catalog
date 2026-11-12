import SwiftUI

struct ItemDetailView: View {
    let item: MinecraftItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ItemHeader(item: item)
                if let recipe = CraftingRecipe.recipe(for: item) {
                    NavigationLink {
                        CraftingRecipeView(recipe: recipe)
                    } label: {
                        Label("查看合成指南", systemImage: "square.grid.3x3.fill")
                            .font(.headline).frame(maxWidth: .infinity).padding(18)
                    }
                    .buttonStyle(BlockButtonStyle(selected: true))
                }
                ItemInfoPanel(title: "用途", symbol: "book.closed.fill", text: item.summary)
                ItemInfoPanel(title: "取得方式", symbol: "pickaxe", text: item.obtaining)
            }
            .padding(20).frame(maxWidth: 720).frame(maxWidth: .infinity)
        }
        .minecraftScreen()
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct ItemHeader: View {
    let item: MinecraftItem

    var body: some View {
        VStack(spacing: 18) {
            Text("物品檔案 / INVENTORY")
                .font(.system(.caption, design: .monospaced, weight: .bold))
                .foregroundStyle(MinecraftTheme.muted)
            ItemSlot(item: item, large: true)
            Text(item.name).font(.largeTitle.bold()).multilineTextAlignment(.center)
            Text(item.englishName).font(.system(.subheadline, design: .monospaced))
                .foregroundStyle(MinecraftTheme.muted)
            Text(item.category).font(.caption.bold())
                .foregroundStyle(MinecraftTheme.ink)
                .padding(.horizontal, 16).padding(.vertical, 8)
                .blockPanel(MinecraftTheme.color(for: item.category))
        }
        .padding(24).frame(maxWidth: .infinity).blockPanel()
    }
}

private struct ItemInfoPanel: View {
    let title: String
    let symbol: String
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label(title, systemImage: symbol).font(.headline).foregroundStyle(MinecraftTheme.green)
            Text(text).font(.body).lineSpacing(6)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(20).frame(maxWidth: .infinity, alignment: .leading).blockPanel()
    }
}
