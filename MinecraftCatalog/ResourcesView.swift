import SwiftUI

struct ResourcesView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack(spacing: 14) {
                    GrassBlockArt().frame(width: 42, height: 42)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("通往更大的世界").font(.headline)
                        Text("Minecraft 官方網站")
                            .font(.caption).foregroundStyle(MinecraftTheme.muted)
                    }
                    Spacer(minLength: 0)
                    Image(systemName: "globe").foregroundStyle(MinecraftTheme.green)
                }
                .padding(16).blockPanel()
                if let url = URL(string: "https://www.minecraft.net/") {
                    WebView(url: url)
                }
            }
            .minecraftScreen()
            .navigationTitle("官方網站")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
