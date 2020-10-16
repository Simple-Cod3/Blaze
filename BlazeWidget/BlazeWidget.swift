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
