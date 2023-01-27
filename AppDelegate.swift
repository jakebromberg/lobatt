//
//  AppDelegate.swift
//  lobatt
//
//  Created by Jake Bromberg on 3/5/21.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
  var menuRefreshTimer: Timer?
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    self.statusItem.menu = NSMenu()
    self.statusItem.menu?.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
    
    self.menuRefreshTimer = .scheduledTimer(withTimeInterval: 30, repeats: true, block: { _ in
      let percent = SystemProfiler.CurrentProfile().power.first!.chargeInfo!.percent
      self.statusItem.button?.title = String(percent) + "%"
      self.statusItem.button?.needsDisplay = true
    })
    
    self.menuRefreshTimer?.fire()
  }
}
