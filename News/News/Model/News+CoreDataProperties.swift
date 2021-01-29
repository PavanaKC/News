//
//  News+CoreDataProperties.swift
//  News
//
//  Created by Pavana, Kc (623-Extern) on 29/01/21.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var author: String?
    @NSManaged public var commentsCount: Int16
    @NSManaged public var explanation: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var likesCount: Int16
    @NSManaged public var title: String?
    @NSManaged public var articleUrl: String?

}

extension News : Identifiable {

}
