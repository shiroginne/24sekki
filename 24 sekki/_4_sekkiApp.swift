import SwiftUI
import Cocoa

@main
struct SmallSeasonsApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var seasonManager: SeasonManager!
    var updateTimer: DispatchSourceTimer?

    func applicationDidFinishLaunching(_ notification: Notification) {
        seasonManager = SeasonManager()
        seasonManager.loadSeasons()

        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusBarItem?.button {
            button.title = currentSeasonSymbol()
            button.toolTip = currentSeasonDescription()
        }

        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Current Season: \(currentSeasonName())", action: nil, keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q"))
        statusBarItem?.menu = menu

        startSeasonUpdateTimer()
    }

    func startSeasonUpdateTimer() {
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global(qos: .background))
        let now = Date()
        let calendar = Calendar.current
        if let nextHour = calendar.nextDate(after: now, matching: DateComponents(minute: 0, second: 0), matchingPolicy: .strict) {
            let interval = nextHour.timeIntervalSinceNow
            timer.schedule(deadline: .now() + interval, repeating: 3600.0)
        } else {
            timer.schedule(deadline: .now() + 3600.0, repeating: 3600.0)
        }
        
        timer.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                self?.updateSeason()
            }
        }
        timer.resume()
        updateTimer = timer
    }
    
    func updateSeason() {
        if let button = statusBarItem?.button {
            button.title = currentSeasonSymbol()
            button.toolTip = currentSeasonDescription()
        }

        statusBarItem?.menu?.item(at: 0)?.title = NSLocalizedString("menu.currentSeason", comment: "") + ": " + currentSeasonName()
    }

    func currentSeasonSymbol() -> String {
        return seasonManager.currentSeason()?.japanese ?? "無季節"
    }

    func currentSeasonName() -> String {
        return seasonManager.currentSeason()?.localizedName ?? NSLocalizedString("season.unknown.name", comment: "")
    }

    func currentSeasonDescription() -> String {
        return seasonManager.currentSeason()?.localizedDescription ?? NSLocalizedString("season.unknown.description", comment: "")
    }

    @objc func quit() {
        NSApplication.shared.terminate(self)
    }
}
