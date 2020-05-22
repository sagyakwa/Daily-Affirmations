//
//  AffirmationItem.swift
//  Daily Affirmations
//
//  Created by Samuel Agyakwa on 5/22/20.
//  Copyright © 2020 Samuel Agyakwa. All rights reserved.
//

import Foundation
import CoreData

public class AffirmationItem: NSManagedObject, Identifiable {
    @NSManaged public var affirmationText: String?
    @NSManaged public var createdAt: Date?
}

extension AffirmationItem {
    static func getAllAffirmations() -> NSFetchRequest<AffirmationItem> {
        let request: NSFetchRequest<AffirmationItem> = AffirmationItem.fetchRequest() as! NSFetchRequest<AffirmationItem>
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
