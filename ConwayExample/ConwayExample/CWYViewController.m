//
//  CWYViewController.m
//  ConwayExample
//
//  Created by Hector Zarate on 2/15/14.
//  Copyright (c) 2014 Hector Zarate. All rights reserved.
//

#import "CWYViewController.h"
#import "CWYCelullarMatrix.h"
@interface CWYViewController ()

@property (nonatomic, strong) IBOutlet UIView *cellularView;
@property (nonatomic, strong) CWYCelullarMatrix *cellularMatrix;

-(IBAction)nextGeneration:(id)sender;

@end

@implementation CWYViewController

- (void)viewDidLoad
{
    self.cellularMatrix = [[CWYCelullarMatrix alloc] initWithWidth:self.cellularView.bounds.size.width+1
                                                            height:self.cellularView.bounds.size.height+1];
    
    [self drawMatrix];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)nextGeneration:(id)sender
{
    NSLog(@"%@", self.cellularMatrix);
    
    [self.cellularView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.cellularMatrix nextGeneration];

    NSLog(@"%@", self.cellularMatrix);
    
    [self drawMatrix];
}

- (void)drawMatrix
{
    for (int matrixIndex = 0;
         matrixIndex < self.cellularMatrix.size.width * self.cellularMatrix.size.height;
         ++matrixIndex)
    {
        if (self.cellularMatrix.currentMatrix[matrixIndex])
        {
            CGPoint point = [self.cellularMatrix pointFromVectorIndex:matrixIndex];
            
            UIView *viewTest = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, 1, 1)];
            viewTest.backgroundColor = [UIColor redColor];
            
            [self.cellularView addSubview:viewTest];
        }/*
        else
        {
            CGPoint point = [self.cellularMatrix pointFromVectorIndex:matrixIndex];
            
            UIView *viewTest = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, 1, 1)];
            viewTest.backgroundColor = [UIColor blackColor];
            
            [self.cellularView addSubview:viewTest];
            
        }*/
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touches

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint touchedPoint =[touch locationInView:self.view];
    
    NSUInteger index = [self.cellularMatrix vectorIndexFromPointX:touchedPoint.x pointY:touchedPoint.y];
    
    self.cellularMatrix.currentMatrix[index] = YES;
    
    
    NSLog(@"Point: %@", NSStringFromCGPoint(touchedPoint));
    
    [self drawMatrix];
}


@end
