import SwiftUI

struct SettingsCardLink<Content: View>: View {
    var title: String
    var desc: String
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .fontWeight(.semibold)
                .font(.title)
                .foregroundColor(.primary)
            
            Text(desc)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
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
        .padding(.horizontal, 20)
    }
}

struct SettingsCardCustom<Content: View>: View {
    var title: String
    var desc: String
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .fontWeight(.semibold)
                .font(.title)
                .foregroundColor(.primary)
            Text(desc)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
            Divider().padding(.bottom, 5)
            
            content()
        }
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding(.horizontal, 20)
    }
}
