//
//  CWYCelullarMatrix.h
//  ConwayExample
//
//  Created by Hector Zarate on 2/15/14.
//  Copyright (c) 2014 Hector Zarate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWYCelullarMatrix : NSObject

@property (nonatomic, strong) NSMutableArray *currentMatrix;

- (id)initWithWidth:(NSUInteger)paramWidth
            height:(NSUInteger)paramHeight;


- (void)nextGeneration;

@end
