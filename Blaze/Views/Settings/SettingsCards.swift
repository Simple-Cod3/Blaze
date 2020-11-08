import SwiftUI

struct SettingsCardLink<Content: View>: View {
    var title: String
    var desc: String
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .fontWeight(.medium)
                .font(.title)
                .foregroundColor(.primary)
            
            Text(desc).foregroundColor(.secondary)
            
            Divider()
                .padding(.bottom, 5)
            
            NavigationLink(destination: content()) {
                HStack {
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color(.tertiaryLabel))
                }
            }
        }
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

struct SettingsCardCustom<Content: View>: View {
    @Binding var loading: Bool
    
    var title: String
    var desc: String
    var content: () -> Content
    
    init(title: String, desc: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.desc = desc
        self._loading = .constant(false)
        self.content = content
    }
    
    init(title: String, desc: String, loading: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.desc = desc
        self._loading = loading
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 0) {
                Text(title)
                    .fontWeight(.medium)
                    .font(.title)
                    .foregroundColor(.primary)
                Spacer()
                ProgressView()
                    .scaleEffect(loading ? 1 : 0)
                    .animation(.spring())
            }
            Text(desc).foregroundColor(.secondary)
            
            Divider().padding(.bottom, 5)
            
            content()
        }
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}
