//
//  Indexable+Utils.swift
//  OMM
//
//  Created by Ivan Nikitin on 04/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

extension Indexable {

    var range: Range<Index> {
        return startIndex..<endIndex
    }

}

extension Indexable where Index: Comparable {

    func valueForIndex(index: Index) -> _Element? {
        return range ~= index ? self[index] : nil
    }
    
}
