//
//  CWYCelullarMatrix.h
//  ConwayExample
//
//  Created by Hector Zarate on 2/15/14.
//  Copyright (c) 2014 Hector Zarate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWYCelullarMatrix : NSObject
@property (nonatomic, assign, readonly) BOOL *currentMatrix;
@property (nonatomic, assign, readonly) CGSize size;

- (id)initWithWidth:(NSUInteger)paramWidth
            height:(NSUInteger)paramHeight;


- (void)nextGeneration;

- (CGPoint)pointFromVectorIndex:(NSUInteger)paramIndex;

- (NSUInteger)vectorIndexFromPointX:(NSUInteger)paramX
                             pointY:(NSUInteger)paramY;



@end
