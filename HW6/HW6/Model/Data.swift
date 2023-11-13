//
//  Data.swift
//  HW6
//
//  Created by 오성진 on 11/7/23.
//

import Foundation
import RealmSwift

class DownloadedItem: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var summary: String = ""
    @objc dynamic var image: Data? // Store image as Data in Realm
}


