// JoyDomShowcase — the smallest end-to-end JoyDom app.
//
// Everything the renderer needs is here, in one file, so the docs can point a
// newcomer at a single screen of code:
//
//   • one inline joy-dom JSON document — exactly what a server would send;
//   • the built-in primitives (`div` / `p` / `h1` / `span` / `img`) plus ONE
//     custom component (`badge`) registered on the side;
//   • a single `.onEvent` handler that drives host `@State`, so a tap
//     re-decodes the document and the view updates.
//
// Runs as-is on iOS (Xcode) and macOS (`swift run JoyDomShowcase`). For the
// rich three-pane conformance tool see `JoyDomDemo` instead — this target is
// deliberately the opposite: minimal, offline, no images, no comparison panes.

import SwiftUI
import JoyDOM

#if os(macOS)
import AppKit

// A SwiftPM executable launches on macOS as an "accessory" with no active
// window. Promote it to a regular app so the showcase window appears and takes
// focus. iOS needs none of this.
final class ShowcaseAppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
    }
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }
}
#endif

@main
struct JoyDomShowcaseApp: App {
    #if os(macOS)
    @NSApplicationDelegateAdaptor(ShowcaseAppDelegate.self) private var delegate
    #endif

    var body: some Scene {
        WindowGroup("JoyDom Showcase") {
            ShowcaseView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding()
            #if os(macOS)
                .frame(minWidth: 420, minHeight: 420)
            #endif
        }
    }
}

struct ShowcaseView: View {
    // The document is a function of host state, so tapping the like button
    // re-decodes the spec below and the count in the title updates.
    @State private var likes = 0

    // Built-in primitives plus one custom `badge` component. `register` is
    // last-wins and chainable; here it adds a node type the spec can use by
    // name (`{ "type": "badge", … }`).
    private let registry: ComponentRegistry = {
        ComponentRegistry()
            .withDefaultPrimitives()
            .register("badge") { context in
                .custom {
                    Text(context.props.string("label") ?? "")
                        .font(.caption.bold())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(Color.accentColor.opacity(0.15)))
                        .foregroundStyle(Color.accentColor)
                }
            }
    }()

    var body: some View {
        JoyDom(spec: cardSpec, components: registry)
            .viewport(Viewport(width: 360))   // drives breakpoint resolution
            // One handler receives every event; branch on `event.name`.
            .onEvent { event in
                if event.name == "like" { likes += 1 }
            }
    }

    // The whole card is one joy-dom JSON document. `cardSpec` is recomputed on
    // every render, so `\(likes)` always reflects the current state.
    private var cardSpec: Spec {
        let json = """
        {
          "version": 1,
          "style": {},
          "breakpoints": [],
          "layout": {
            "type": "div",
            "props": { "id": "card", "style": {
              "display": "flex", "flexDirection": "column",
              "gap": { "value": 14, "unit": "px" },
              "padding": { "value": 24, "unit": "px" },
              "backgroundColor": "#ffffff",
              "borderRadius": { "value": 16, "unit": "px" },
              "borderWidth": { "value": 1, "unit": "px" },
              "borderStyle": "solid",
              "borderColor": "#e2e8f0"
            } },
            "children": [
              { "type": "h1", "props": { "style": {
                  "fontSize": { "value": 24, "unit": "px" },
                  "fontWeight": "bold", "color": "#0f172a",
                  "margin": { "value": 0, "unit": "px" }
                } },
                "children": ["JoyDom"] },

              { "type": "p", "props": { "style": {
                  "fontSize": { "value": 15, "unit": "px" }, "color": "#475569",
                  "margin": { "value": 0, "unit": "px" }
                } },
                "children": ["One JSON document, rendered as native SwiftUI."] },

              { "type": "div", "props": { "id": "tags", "style": {
                  "display": "flex", "flexDirection": "row",
                  "gap": { "value": 8, "unit": "px" }
                } },
                "children": [
                  { "type": "badge", "props": { "label": "SwiftUI" } },
                  { "type": "badge", "props": { "label": "Flexbox" } },
                  { "type": "badge", "props": { "label": "Spec-driven" } }
                ] },

              { "type": "div", "props": {
                  "id": "like-button",
                  "style": {
                    "display": "flex", "alignSelf": "flex-start",
                    "padding": { "value": 12, "unit": "px" },
                    "backgroundColor": "#6366f1",
                    "borderRadius": { "value": 10, "unit": "px" }
                  },
                  "onclick": { "type": "event", "name": "like" }
                },
                "children": [
                  { "type": "p", "props": { "style": {
                      "color": "#ffffff", "fontWeight": "bold",
                      "fontSize": { "value": 15, "unit": "px" },
                      "margin": { "value": 0, "unit": "px" }
                    } },
                    "children": ["\u{2665} Like (\(likes))"] }
                ] }
            ]
          }
        }
        """
        // Authored by hand above, so a decode failure is a programmer error.
        return (try? JSONDecoder().decode(Spec.self, from: Data(json.utf8)))
            ?? Spec(layout: Node(type: "div"))
    }
}
