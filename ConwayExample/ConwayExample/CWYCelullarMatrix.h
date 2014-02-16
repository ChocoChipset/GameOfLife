//
//  CWYCelullarMatrix.h
//  ConwayExample
//
//  Created by Hector Zarate on 2/15/14.
//  Copyright (c) 2014 Hector Zarate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWYCelullarMatrix : NSObject
@property (nonatomic, assign) BOOL *currentMatrix;
@property (nonatomic, assign, readonly) CGSize size;
@property (nonatomic, readonly) NSUInteger length;

- (id)initWithWidth:(NSUInteger)paramWidth
            height:(NSUInteger)paramHeight;


- (void)nextGeneration;

- (void)clearCurrentMatrix;

- (CGPoint)pointFromVectorIndex:(NSUInteger)paramIndex;

- (NSUInteger)vectorIndexFromPointX:(NSUInteger)paramX
                             pointY:(NSUInteger)paramY;



@end
