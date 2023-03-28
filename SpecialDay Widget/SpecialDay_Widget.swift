//
//  SpecialDay_Widget.swift
//  SpecialDay Widget
//
//  Created by Hoju Choi on 2023/03/28.
//

import WidgetKit
import SwiftUI

struct WidgetItem: Codable {
    let title: String
    let days: Int
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: "DDay", days: 100)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        if context.isPreview {
            let entry = SimpleEntry(
                date: Date(),
                title: "DDay",
                days: 100
            )
            
            completion(entry)
            return
        }
        
        Task {
            let date = Date()
            
            if let data = UserDefaults.standard.object(forKey: "widget_item") as? Data,
               let item = try? JSONDecoder().decode(WidgetItem.self, from: data) {
                let entry = SimpleEntry(date: date, title: item.title, days: item.days)
                completion(entry)
            } else {
                let entry = SimpleEntry(date: date, title: "DDay", days: 100)
                completion(entry)
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        guard let data = UserDefaults.standard.object(forKey: "widget_item") as? Data,
              let item = try? JSONDecoder().decode(WidgetItem.self, from: data)
        else {
            completion(Timeline(entries: entries, policy: .atEnd))
            return
        }

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, title: item.title, days: item.days)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let days: Int
}

struct SpecialDay_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        HStack {
            Text("\(entry.title) \(entry.days)")
        }
    }
}

@main
struct SpecialDay_Widget: Widget {
    let kind: String = "SpecialDay_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SpecialDay_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.accessoryInline])
    }
}

struct SpecialDay_Widget_Previews: PreviewProvider {
    static var previews: some View {
        SpecialDay_WidgetEntryView(entry: SimpleEntry(date: Date(), title: "DDay Test", days: 123))
            .previewContext(WidgetPreviewContext(family: .accessoryInline))
    }
}
