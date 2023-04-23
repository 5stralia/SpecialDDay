//
//  WatchConnectivityManager.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/23.
//

import Combine
import Foundation
import WatchConnectivity

final class WatchConnectivityManager: NSObject, ObservableObject {
    enum MessageKey {
        case items

        var stringValue: String {
            switch self {
            case .items: return "items"
            }
        }
    }

    static let shared = WatchConnectivityManager()

    @Published var items: [ItemEntity] = []

    private override init() {
        super.init()

        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }

        #if os(watchOS)
        if let data = UserDefaults.standard.object(forKey: MessageKey.items.stringValue) as? Data,
           let items = try? JSONDecoder().decode([ItemEntity].self, from: data) {
            self.items = items
        }
        #endif
    }

    func send(_ items: [ItemEntity]) {
        guard WCSession.default.activationState == .activated else { return }

        #if os(iOS)
        guard WCSession.default.isWatchAppInstalled else { return }
        #else
        guard WCSession.default.isCompanionAppInstalled else { return }
        #endif

        do {
            let data = try JSONEncoder().encode(items)
            try WCSession.default.updateApplicationContext([MessageKey.items.stringValue: data])
        } catch let error {
            print(String(describing: error))
        }
    }
}

extension WatchConnectivityManager: WCSessionDelegate {
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {

    }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) { }
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    #endif

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        guard let data = applicationContext[MessageKey.items.stringValue] as? Data else { return }

        do {
            let items = try JSONDecoder().decode([ItemEntity].self, from: data)
            self.items = items

            UserDefaults.standard.set(data, forKey: MessageKey.items.stringValue)
        } catch let error {
            print("Cannot receive Data: \(String(describing: error))")
        }
    }

}
