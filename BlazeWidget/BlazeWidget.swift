//
// BlazeWidget.swift
// BlazeWidget
//
// Created by Max on 10/15/20.
//
//
import WidgetKit
import SwiftUI
let snapshotEntry = WidgetContent(number: "415-999-9999")


struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetContent {
        snapshotEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetContent) -> ()) {
        let entry = WidgetContent(date: Date(), number: "xx")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WidgetContent] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(
                byAdding: .hour,
                value: hourOffset,
                to: currentDate
            )!
            let entry = snapshotEntry
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

@main
struct BlazeWidget: Widget {
    private let kind: String = "BlazeWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EntryView(model: entry)
        }
        .configurationDisplayName("Swift's Latest Commit")
        .description("Shows the last commit at the Swift repo.")
    }
}

struct BlazeWidget_Previews: PreviewProvider {
    static var previews: some View {
        LargeWidget(aq: "39", index: "unhealthy", biggestName: "August Complex", biggestArea: "1,000,000", name1: "August Complex", name2: "Elkhorn Fire", size1: "1,200,000", size2: "236,288")
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}

struct SmallWidget: View {
    var size: String
    
    var body: some View {
        VStack {
            Text("The biggest wildfire in California is now ")
                .font(.title2)
                .fontWeight(.semibold)
            + Text(size)
                .foregroundColor(Color.yellow)
                .font(.title2)
                .fontWeight(.semibold)
            + Text(" acres")
                .foregroundColor(.primary)
                .font(.title2)
                .fontWeight(.semibold)
        }
        .padding(5)
    }
}

struct MediumWidget: View {
    var aq: String
    var index: String
    var name1: String
    var name2: String
    var size1: String
    var size2: String
    
    var body: some View {
        VStack {
            HStack {
                Text(aq)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(15)
                    .foregroundColor(Color.yellow)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Circle())
                Spacer()
                
                Text("Your local air quality is ")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                + Text(index)
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.yellow)
            }
            Spacer()
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(name1)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    Text(size1 + " acres")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                .padding(.trailing, 20)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(name2)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    Text(size2 + " acres")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                Spacer()
            }
        }
        .padding(15)
    }
}

struct LargeWidget: View {
    var aq: String
    var index: String
    var biggestName: String
    var biggestArea: String
    var name1: String
    var name2: String
    var size1: String
    var size2: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(aq)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(15)
                    .foregroundColor(Color.yellow)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Circle())
                Spacer()
                
                Text("Your local air quality is ")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                + Text(index)
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.yellow)
            }
            Spacer()
            
            VStack(spacing: 15) {
                Text("The ")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                + Text(biggestName)
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.yellow)
                + Text(" is now ")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                + Text(biggestArea)
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.yellow)
                + Text(" acres")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(name1)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        Text(size1 + " acres")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                    .padding(.trailing, 20)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(name2)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        Text(size2 + " acres")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(name1)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        Text(size1 + " acres")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                    .padding(.trailing, 20)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(name2)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        Text(size2 + " acres")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(name1)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        Text(size1 + " acres")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                    .padding(.trailing, 20)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(name2)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        Text(size2 + " acres")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 22)
    }
}
