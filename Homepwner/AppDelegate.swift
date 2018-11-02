//
//  AppDelegate.swift
//  Homepwner
//
//  Created by Navneet Babra on 10/14/18.
//  Copyright © 2018 nsbabra. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let itemStore = ItemStore()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print(#function)
        print(Bundle.main.bundlePath)
        //Create ItemStore
//        let itemStore = ItemStore()

        //Create ImageStore
        let imageStore = ImageStore()
        //Access ItemsViewController and set its item store
        let navController = window!.rootViewController as! UINavigationController
        let itemsController = navController.topViewController as! ItemsViewController
        
        itemsController.itemStore = itemStore
        itemsController.imageStore = imageStore

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print(#function)

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)

        let success = itemStore.saveChanged()
        if (success) {
            print("Saved items")
        } else {
            print("Couldn't save any of the items")
        }
    }


    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function)

        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print(#function)

    }

}

