//
//  Function.swift
//  MenuList
//
//  Created by APPLE on 25/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation
import UIKit

func loadJson(filename fileName: String) -> [MenuData]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([MenuData].self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}


