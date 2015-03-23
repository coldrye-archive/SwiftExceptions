//
//  NSException+SwiftExceptions.h
//  SwiftExceptions
//
//  Created by Carsten Klein on 15-03-12.
//  Copyright (c) 2015 vibeswift. All rights reserved.
//

#import <Foundation/Foundation.h>

void _tryCatchFinally(void (^try)(void),
                      void (^catch)(NSException *exception),
                      void (^finally)(void));
