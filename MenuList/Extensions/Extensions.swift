//
//  Extensions.swift
//  MenuList
//
//  Created by APPLE on 26/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
