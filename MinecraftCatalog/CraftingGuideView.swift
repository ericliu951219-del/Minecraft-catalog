import SwiftUI

struct CraftingGuideView: View {
    @State private var search = ""
    @State private var recipes = CraftingRecipe.all

    var body: some View {
        NavigationStack {
            List {
                VStack(alignment: .leading, spacing: 8) {
                    Label("工作台合成指南", systemImage: "square.grid.3x3.fill")
                        .font(.title2.bold()).foregroundStyle(MinecraftTheme.green)
                    Text("Java 版 1.21.4 · \(CraftingRecipe.all.count) 種常用配方")
                        .font(.caption).foregroundStyle(MinecraftTheme.muted)
                    Text("選擇物品，查看材料與擺放方式。").font(.subheadline)
                }
                .padding(.vertical, 12)
                .listRowBackground(Color.clear)

                ForEach(recipes) { recipe in
                    NavigationLink {
                        CraftingRecipeView(recipe: recipe)
                    } label: {
                        HStack(spacing: 14) {
                            RecipeIcon(asset: "item_" + recipe.id)
                            VStack(alignment: .leading, spacing: 6) {
                                Text(recipe.name).font(.headline)
                                Text("每次產出 \(recipe.count) 個")
                                    .font(.caption).foregroundStyle(MinecraftTheme.muted)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                    .listRowBackground(MinecraftTheme.panel)
                }
                if recipes.isEmpty {
                    ContentUnavailableView.search(text: search)
                        .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .minecraftScreen()
            .navigationTitle("合成指南")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $search, prompt: "搜尋物品或材料")
            .onChange(of: search) {
                recipes = CraftingRecipe.all.filter { recipe in
                    search.isEmpty || recipe.name.localizedCaseInsensitiveContains(search)
                        || (recipe.item?.englishName.localizedCaseInsensitiveContains(search) ?? false)
                        || recipe.ingredients.contains { $0.name.localizedCaseInsensitiveContains(search) }
                }
            }
        }
    }
}

struct CraftingRecipeView: View {
    let recipe: CraftingRecipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                RecipeWorkbench(recipe: recipe)
                RecipeMaterials(ingredients: recipe.ingredients)
                Text("Java 版 1.21.4").font(.caption).foregroundStyle(MinecraftTheme.muted)
            }
            .padding(20).frame(maxWidth: 600).frame(maxWidth: .infinity)
        }
        .minecraftScreen()
        .navigationTitle(recipe.name + "合成")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct RecipeWorkbench: View {
    let recipe: CraftingRecipe

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Label("工作台 · 3 × 3", systemImage: "square.grid.3x3.fill")
                .font(.headline).foregroundStyle(MinecraftTheme.green)
            Grid(horizontalSpacing: 6, verticalSpacing: 6) {
                ForEach(0..<3) { row in
                    GridRow {
                        ForEach(0..<3) { column in
                            RecipeCell(ingredient: recipe.slots[row * 3 + column],
                                       row: row, column: column)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            Text(recipe.note).font(.subheadline).foregroundStyle(MinecraftTheme.muted)
                .fixedSize(horizontal: false, vertical: true)
            HStack(spacing: 16) {
                Image(systemName: "arrow.down").foregroundStyle(MinecraftTheme.green)
                RecipeIcon(asset: "item_" + recipe.id)
                VStack(alignment: .leading, spacing: 4) {
                    Text(recipe.name).font(.headline)
                    Text("產出 × \(recipe.count)").foregroundStyle(MinecraftTheme.green)
                }
            }
        }
        .padding(20).frame(maxWidth: .infinity, alignment: .leading).blockPanel()
    }
}

private struct RecipeCell: View {
    let ingredient: String?
    let row: Int
    let column: Int

    var body: some View {
        ZStack {
            MinecraftTheme.ink
            if let ingredient {
                Image("item_" + ingredient).resizable().interpolation(.none)
                    .scaledToFit().padding(10)
            }
        }
        .frame(width: 58, height: 58)
        .overlay { Rectangle().strokeBorder(MinecraftTheme.muted.opacity(0.5), lineWidth: 2) }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("第 \(row + 1) 列，第 \(column + 1) 格：\(ingredient.map { CraftingRecipe.ingredientName($0) } ?? "空白")")
    }
}

private struct RecipeMaterials: View {
    let ingredients: [CraftingIngredient]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("材料清單 · 合成一次").font(.headline).foregroundStyle(MinecraftTheme.green)
            ForEach(ingredients) { ingredient in
                HStack(spacing: 12) {
                    RecipeIcon(asset: ingredient.imageName)
                    Text(ingredient.name).fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    Text("× \(ingredient.count)").monospacedDigit()
                }
            }
        }
        .padding(20).blockPanel()
    }
}

private struct RecipeIcon: View {
    let asset: String

    var body: some View {
        Image(asset).resizable().interpolation(.none).scaledToFit()
            .frame(width: 40, height: 40).padding(8)
            .blockPanel(MinecraftTheme.ink)
            .accessibilityHidden(true)
    }
}
