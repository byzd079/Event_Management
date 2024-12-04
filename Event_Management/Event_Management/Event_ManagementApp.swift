//
//  Event_ManagementApp.swift
//  Event_Management
//
//  Created by Gaming Lab on 3/12/24.
//

import SwiftUI
import Firebase

@main
struct Event_ManagementApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
