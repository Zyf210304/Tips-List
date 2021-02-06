//
//  Tips_ListApp.swift
//  Tips List
//
//  Created by 张亚飞 on 2021/2/5.
//

import SwiftUI

@main
struct Tips_ListApp: App {
    var body: some Scene {
        
        let obs = observer()
        WindowGroup {
            ContentView()
                .environmentObject(obs)
        }
    }
}
