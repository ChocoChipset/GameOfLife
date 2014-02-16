//
//  CWYCelullarMatrix.m
//  ConwayExample
//
//  Created by Hector Zarate on 2/15/14.
//  Copyright (c) 2014 Hector Zarate. All rights reserved.
//

#import "CWYCelullarMatrix.h"


@interface CWYCelullarMatrix ()

@property (nonatomic, assign) BOOL *currentMatrix;

@property (nonatomic, assign) CGSize size;

- (NSUInteger)numberOfNeighboursForIndex:(NSUInteger)paramIndex;

@end

@implementation CWYCelullarMatrix

#pragma mark - Initializer

- (id)initWithWidth:(NSUInteger)paramWidth
             height:(NSUInteger)paramHeight
{
    self = [super init];
    
    if (self)
    {
        _currentMatrix = calloc(paramWidth * paramHeight, sizeof(BOOL));
        _size = CGSizeMake(paramWidth, paramHeight);
    }
    
    return self;
}

-(void)dealloc
{
    free(self.currentMatrix);
}


- (NSUInteger)numberOfNeighboursForIndex:(NSUInteger)paramIndex
{
    // I'm sure there is a more elegant solution to this, but let's keep it nasty for now.
    // Idea: method that returns nil when accessing out of bounds array instead of exception
    
    
    CGPoint point = [self pointFromVectorIndex:paramIndex];
    
    BOOL topEdge = NO, rightEdge = NO, bottomEdge = NO, leftEdge = NO;
    
    if (point.y == 0) topEdge = YES;
    if (point.x == self.size.width) rightEdge = YES;
    if (point.y == self.size.height) bottomEdge = YES;
    if (point.x == 0) leftEdge = YES;
    
    NSUInteger sum = 0;
    
    if (!topEdge)
    {
        sum += self.currentMatrix[[self vectorIndexFromPointX:point.x
                                                       pointY:point.y-1]];
    }
    if (!rightEdge)
    {
        sum += self.currentMatrix[[self vectorIndexFromPointX:point.x+1
                                                       pointY:point.y]];
    }
    if (!bottomEdge)
    {
        sum += self.currentMatrix[[self vectorIndexFromPointX:point.x
                                                       pointY:point.y+1]];
    }
    if (!leftEdge)
    {
        sum += self.currentMatrix[[self vectorIndexFromPointX:point.x-1
                                                       pointY:point.y]];
    }
    if (!topEdge && !leftEdge)
    {
        sum += self.currentMatrix[[self vectorIndexFromPointX:point.x-1
                                                       pointY:point.y-1]];
    }
    if (!topEdge && !rightEdge)
    {
        sum += self.currentMatrix[[self vectorIndexFromPointX:point.x+1
                                                       pointY:point.y-1]];
    }
    if (!bottomEdge && !rightEdge)
    {
        sum += self.currentMatrix[[self vectorIndexFromPointX:point.x+1
                                                       pointY:point.y+1]];
    }
    if (!bottomEdge && !leftEdge)
    {
        sum += self.currentMatrix[[self vectorIndexFromPointX:point.x-1
                                                       pointY:point.y+1]];
        
    }

    return sum;
}


- (void)nextGeneration
{
    BOOL *nextMatrix = calloc(self.length, sizeof(BOOL));
    
    for (NSUInteger traverseIndex = 0;
         traverseIndex < self.length;
         ++traverseIndex)
    {
        if ([self numberOfNeighboursForIndex:traverseIndex] < 2 ||
            [self numberOfNeighboursForIndex:traverseIndex] > 3)
        {
            nextMatrix[traverseIndex] = NO;
        }
        else if (self.currentMatrix[traverseIndex] &&
                 ([self numberOfNeighboursForIndex:traverseIndex] == 2 ||
                 [self numberOfNeighboursForIndex:traverseIndex] == 3))
        {
            nextMatrix[traverseIndex] = YES;
        }
        else if (!self.currentMatrix[traverseIndex] &&
                 [self numberOfNeighboursForIndex:traverseIndex] == 3)
        {
            nextMatrix[traverseIndex] = YES;
        }
    }
    
    free(self.currentMatrix);
    
    self.currentMatrix = nextMatrix;
}

- (NSUInteger)vectorIndexFromPointX:(NSUInteger)paramX
                             pointY:(NSUInteger)paramY
{
    NSUInteger minorComponent = paramX;
    NSUInteger mayorComponent = paramY * self.size.width;
    
    return mayorComponent + minorComponent;
}

- (CGPoint)pointFromVectorIndex:(NSUInteger)paramIndex
{
    NSInteger row = (NSUInteger)paramIndex / (NSUInteger)self.size.width;
    NSInteger column = paramIndex - (self.size.width * row);
    
    return CGPointMake(column, row);
}

- (NSUInteger)length
{
    return self.size.width * self.size.height;
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString string];
    
    for (int i=0; i<self.size.height; ++i)
    {
        for (int j=0; j<self.size.width; ++j)
        {
            NSUInteger index = [self vectorIndexFromPointX:i
                                                    pointY:j];
            
            [description appendFormat:@"%d", self.currentMatrix[index]];
        }
        
        [description appendString:@"\n"];
    }
    
    return description;
}

@end


