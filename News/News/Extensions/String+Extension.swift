//
//  String+Extension.swift
//  News
//
//  Created by PavanaKC on 01/02/21.
//

import UIKit

extension String {
    /// Get bounding size for the String
    func getStringBoundingSize(boundingBox : CGSize, font : UIFont) -> CGSize {
        let boundingSize = self.boundingRect(with: boundingBox, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font : font], context: nil).size
        
        return CGSize(width: ceil(boundingSize.width), height: ceil(boundingSize.height))
    }
}
