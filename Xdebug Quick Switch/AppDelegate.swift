//
//  AppDelegate.swift
//  Xdebug Quick Switch
//
//  Created by Jaesin Mulenex on 2/17/15.
//  Copyright (c) 2015 Jaesin Mulenex. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    let ioManager = NSFileManager.defaultManager()

    let enabledFullPath = "/usr/local/etc/php/5.5/conf.d/ext-xdebug.ini"
    let disabledFullPath = "/usr/local/etc/php/5.5/conf.d/ext-xdebug.ini.disabled"
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let icon = NSImage(named: "statusIcon")
//        icon.setTemplate(true)
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func quitMenuItemClicked(sender: NSMenuItem) {
        // Exit the utility.
        NSApplication.sharedApplication().terminate(self)
    }
    @IBAction func enableMenuItemClicked(sender: NSMenuItem) {
        
        if(ioManager.fileExistsAtPath(disabledFullPath)){
            let task1 = NSTask()
            
            task1.launchPath = "/bin/mv"
            
            task1.arguments = [disabledFullPath, enabledFullPath]
            task1.launch()
            task1.waitUntilExit()
            
            let task2 = NSTask()
            
            task2.launchPath = "/usr/bin/sudo"
            
            task2.arguments = ["/usr/sbin/apachectl", "-k", "graceful"]
            task2.launch()
            task2.waitUntilExit()
        }
    }
    @IBAction func disableMenuItemClicked(sender: NSMenuItem) {
        if(ioManager.fileExistsAtPath(enabledFullPath)){
        
            let task1 = NSTask()
            
            task1.launchPath = "/bin/mv"
            
            task1.arguments = [enabledFullPath, disabledFullPath]
            task1.launch()
            task1.waitUntilExit()
            
            let task2 = NSTask()
            
            task2.launchPath = "/usr/bin/sudo"
            
            task2.arguments = ["/usr/sbin/apachectl", "-k", "graceful"]
            task2.launch()
            task2.waitUntilExit()
        }
    }
}

