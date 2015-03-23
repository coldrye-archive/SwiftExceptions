//
//  SwiftExceptions.swift
//  SwiftExceptions
//
//  Created by Carsten Klein on 15-03-23.
//  Copyright (c) 2015 vibeswift. All rights reserved.
//

import Foundation

public func try(try: (Void) -> Void,
             #catch: (exception: NSException!) -> Void) {

    _tryCatchFinally(try, catch, nil)
}

public func try(try: (Void) -> Void,
           #finally: (Void) -> Void) {

    _tryCatchFinally(try, nil, finally)
}

public func try(try: (Void) -> Void,
             #catch: (exception: NSException!) -> Void,
           #finally: (Void) -> Void) {

    _tryCatchFinally(try, catch, finally)
}
