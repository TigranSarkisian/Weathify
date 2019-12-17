//
//  File.swift
//  Weathify
//
//  Created by macbook-097 on 12/13/19.
//  Copyright © 2019 Tigran Sarkisyan. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SwiftyBeaver


class WeatherDatabaseManager {
    
    static func storeCurrentTemp(currentTemp: String){
        let managedContext = CoreDataHelper.shared.persistentContainer.viewContext
        let weatherEntity = NSEntityDescription.entity(forEntityName: "Weather", in: managedContext)!
        
        let weatherObj = NSManagedObject(entity: weatherEntity, insertInto: managedContext)
        weatherObj.setValue(currentTemp, forKeyPath: "currentTemp")
        
        do {
            try managedContext.save()
            retrieveCurrentTemp()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func retrieveCurrentTemp() {
        let managedContext = CoreDataHelper.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            for data in result as! [NSManagedObject] {
                SwiftyBeaver.debug(data.value(forKey: "currentTemp") as! String)
            }
        } catch {
            SwiftyBeaver.error("Failed to fetch data from DB!")
        }
    }
    
}
