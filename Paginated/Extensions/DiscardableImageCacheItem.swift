//
//  Discardable.swift
//  Paginated
//
//  Created by Admin on 10/7/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit
/*
 *MARK:- By The Apple Documentation Itself
 *MARK:- An NSDiscardableContent object’s life cycle is dependent upon a “counter” variable. An NSDiscardableContent object is a purgeable block of memory that keeps track of whether or not it is currently being used by some other object. When this memory is being read, or is still needed, its counter variable will be greater than or equal to 1. When it is not being used, and can be discarded, the counter variable will be equal to 0.
 
 * When the counter is equal to 0, the block of memory may be discarded if memory is tight at that point in time. In order to discard the content, call discardContentIfPossible() on the object, which will free the associated memory if the counter variable equals 0.
 
 * By default, NSDiscardableContent objects are initialized with their counter equal to 1 to ensure that they are not immediately discarded by the memory-management system. From this point, you must keep track of the counter variable’s state. Calling the beginContentAccess() method increments the counter variable by 1, thus ensuring that the object will not be discarded. When you no longer need the object, decrement its counter by calling endContentAccess().
 
 * The Foundation framework includes the NSPurgeableData class, which provides a default implementation of this protocol.
 *
 */

/**
 MARK:- In general Term's NSDiscardableContent is meant to be used to allow whatever implements it to track its own usage and discard its own content if necessary
 ***/
open class DiscardableImageCacheItem: NSObject, NSDiscardableContent {
    
    private(set) public var image: UIImage?
    var accessCount: UInt = 0
    
    public init(image: UIImage) {
        self.image = image
    }
    
    public func beginContentAccess() -> Bool {
        if image == nil {
            return false
        }
        
        accessCount += 1
        return true
    }
    
    public func endContentAccess() {
        if accessCount > 0 {
            accessCount -= 1
        }
    }
    
    public func discardContentIfPossible() {
        if accessCount == 0 {
            image = nil
        }
    }
    
    public func isContentDiscarded() -> Bool {
        return image == nil
    }
    
}
