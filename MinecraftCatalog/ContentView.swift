import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("圖鑑", systemImage: "square.grid.2x2.fill") { LibraryView() }
            Tab("分類漫遊", systemImage: "map.fill") { JourneyView() }
            Tab("合成指南", systemImage: "square.grid.3x3.fill") { CraftingGuideView() }
            Tab("官方網站", systemImage: "globe.asia.australia") { ResourcesView() }
        }
        .tint(MinecraftTheme.green)
        .preferredColorScheme(.dark)
    }
}
