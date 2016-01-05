//
//  CollectionType+Utils.swift
//  OMM
//
//  Created by Ivan Nikitin on 04/11/15.
//  Copyright © 2015 Ivan Nikitin. All rights reserved.
//

extension CollectionType {

    var range: Range<Index> {
        return startIndex..<endIndex
    }

}

extension CollectionType where Index: Comparable {

    func valueForIndex(index: Index) -> Generator.Element? {
        return range ~= index ? self[index] : nil
    }
    
}
