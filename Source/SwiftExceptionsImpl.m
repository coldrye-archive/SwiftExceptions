//
//  NSException+SwiftExceptions.m
//  SwiftExceptions
//
//  Created by Carsten Klein on 15-03-12.
//  Copyright (c) 2015 vibeswift. All rights reserved.
//

#import "SwiftExceptionsImpl.h"

void _tryCatchFinally(void (^try)(void),
                      void (^catch)(NSException *exception),
                      void (^finally)(void)) {

    NSException *thrown = nil;

    @try {
        try();
    }
    @catch (NSException *exception) {
        if (catch == nil) {
            thrown = exception;
        }
        else {
            @try {
                catch(exception);
            }
            @catch (NSException *exception) {
                thrown = exception;
            }
        }
    }
    @finally {
        if (finally != nil) {
            finally();
        }
    }

    if (thrown != nil) {
        @throw thrown;
    }
}
