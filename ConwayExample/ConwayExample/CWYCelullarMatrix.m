//
//  CWYCelullarMatrix.m
//  ConwayExample
//
//  Created by Hector Zarate on 2/15/14.
//  Copyright (c) 2014 Hector Zarate. All rights reserved.
//

#import "CWYCelullarMatrix.h"

@interface NSMutableArray (EmptySpaces)

-(void)addEmptySpaces:(NSUInteger)paramNumberOfSpaces;

@end

@implementation NSMutableArray (EmptySpaces)

-(void)addEmptySpaces:(NSUInteger)paramNumberOfSpaces
{
    for (NSUInteger spacesIndex = 0;
         spacesIndex < paramNumberOfSpaces;
         ++paramNumberOfSpaces)
    {
        [self addObject:@(NO)];
    }
}

@end


@interface CWYCelullarMatrix ()

@property (nonatomic, strong) NSMutableArray *nextMatrix;
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
        _currentMatrix = [NSMutableArray array];
        [_currentMatrix addEmptySpaces:paramHeight * paramWidth];
        
        _size = CGSizeMake(paramWidth, paramHeight);
    }
    
    return self;
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
        sum = [self.currentMatrix[[self vectorIndexFromPointX:point.x
                                                       pointY:point.y-1]] boolValue];
    }
    if (!rightEdge)
    {
        sum = [self.currentMatrix[[self vectorIndexFromPointX:point.x+1
                                                       pointY:point.y]] boolValue];
    }
    if (!bottomEdge)
    {
        sum = [self.currentMatrix[[self vectorIndexFromPointX:point.x
                                                       pointY:point.y+1]] boolValue];
    }
    if (!leftEdge)
    {
        sum = [self.currentMatrix[[self vectorIndexFromPointX:point.x-1
                                                       pointY:point.y]] boolValue];
    }
    if (!topEdge && !leftEdge)
    {
        sum = [self.currentMatrix[[self vectorIndexFromPointX:point.x-1
                                                       pointY:point.y-1]] boolValue];
    }
    if (!topEdge && !rightEdge)
    {
        sum = [self.currentMatrix[[self vectorIndexFromPointX:point.x+1
                                                       pointY:point.y-1]] boolValue];
    }
    if (!bottomEdge && !rightEdge)
    {
        sum = [self.currentMatrix[[self vectorIndexFromPointX:point.x+1
                                                       pointY:point.y+1]] boolValue];
    }
    if (!bottomEdge && !leftEdge)
    {
        sum = [self.currentMatrix[[self vectorIndexFromPointX:point.x-1
                                                       pointY:point.y+1]] boolValue];
        
    }

    return sum;
}


- (void)nextGeneration
{
    NSMutableArray *nextMatrix = [NSMutableArray array];
    
    for (NSUInteger traverseIndex = 0;
         traverseIndex < self.size.width * self.size.height;
         ++traverseIndex)
    {
        if ([self numberOfNeighboursForIndex:traverseIndex] < 2 ||
            [self numberOfNeighboursForIndex:traverseIndex] > 3)
        {
            nextMatrix[traverseIndex] = @(NO);
        }
        else if ([self.currentMatrix[traverseIndex] boolValue] &&
                 ([self numberOfNeighboursForIndex:traverseIndex] == 2 ||
                 [self numberOfNeighboursForIndex:traverseIndex] == 3))
        {
            nextMatrix[traverseIndex] = @(YES);
        }
        else if (![self.currentMatrix[traverseIndex] boolValue] &&
                 [self numberOfNeighboursForIndex:traverseIndex] == 3)
        {
            nextMatrix[traverseIndex] = @(YES);
        }
    }
    
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
    NSUInteger row = paramIndex / (NSUInteger)self.size.width;
    NSUInteger column = paramIndex - self.size.width * row;
    
    return CGPointMake(row, column);
}


@end


