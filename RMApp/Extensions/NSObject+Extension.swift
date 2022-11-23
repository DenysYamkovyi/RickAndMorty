//
//  NSObject_extension.swift
//  RMApp
//
//  Created by macbook pro on 2022-11-22.
//

import UIKit

extension NSObject {
    
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    
}
