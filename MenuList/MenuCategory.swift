//
//  MenuCategory.swift
//  MenuList
//
//  Created by APPLE on 25/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation
import UIKit

struct MenuData: Decodable {
    var name: String
    var sub_category: [SubCategory]
}

struct SubCategory : Decodable {
    var name: String
    var display_name: String
}

