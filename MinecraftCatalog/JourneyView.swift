import SwiftUI

private struct CatalogChapter: Identifiable {
    let id: String
    let number: Int
    let items: [MinecraftItem]

    static let all = Catalog.categories.enumerated().map { index, category in
        CatalogChapter(id: category, number: index + 1, items: Catalog.items.filter { $0.category == category })
    }
}

struct JourneyView: View {
    var body: some View {
        NavigationStack {
            TabView {
                ForEach(CatalogChapter.all) { chapter in
                    ChapterPage(chapter: chapter)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .minecraftScreen()
            .navigationTitle("分類漫遊")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: MinecraftItem.self) { ItemDetailView(item: $0) }
        }
    }
}

private struct ChapterPage: View {
    let chapter: CatalogChapter

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("探索手冊 / 0\(chapter.number)")
                        .font(.system(.caption, design: .monospaced, weight: .bold))
                        .foregroundStyle(MinecraftTheme.muted)
                    Label(chapter.id, systemImage: chapter.items.first?.symbol ?? "cube")
                        .font(.largeTitle.bold())
                        .foregroundStyle(MinecraftTheme.color(for: chapter.id))
                    Text("第 \(chapter.number) / \(Catalog.categories.count) 頁 · 左右滑動探索")
                        .font(.caption).foregroundStyle(MinecraftTheme.muted)
                    Rectangle().fill(MinecraftTheme.color(for: chapter.id)).frame(height: 4)
                }
                .padding(20).blockPanel()
                ForEach(chapter.items) { item in
                    NavigationLink(value: item) {
                        HStack(alignment: .top, spacing: 14) {
                            ItemSlot(item: item)
                            VStack(alignment: .leading, spacing: 8) {
                                Text(item.name).font(.headline).foregroundStyle(.white)
                                Text(item.summary).font(.subheadline)
                                    .foregroundStyle(MinecraftTheme.muted)
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer(minLength: 0)
                            Image(systemName: "chevron.right")
                                .font(.caption.bold()).foregroundStyle(MinecraftTheme.green)
                        }
                        .padding(16)
                    }
                    .buttonStyle(BlockButtonStyle())
                }
            }
            .padding(16).padding(.bottom, 50)
            .frame(maxWidth: 720).frame(maxWidth: .infinity)
        }
    }
}
