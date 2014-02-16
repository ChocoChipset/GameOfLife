//
//  CWYViewController.m
//  ConwayExample
//
//  Created by Hector Zarate on 2/15/14.
//  Copyright (c) 2014 Hector Zarate. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "CWYViewController.h"
#import "CWYCelullarMatrix.h"

const NSUInteger CWYGridFactor = 8;

@interface CWYViewController ()

@property (nonatomic, strong) IBOutlet UIView *cellularView;
@property (nonatomic, strong) CWYCelullarMatrix *cellularMatrix;

-(IBAction)nextGeneration:(id)sender;

@end

@implementation CWYViewController

- (void)viewDidLoad
{
    self.cellularMatrix = [[CWYCelullarMatrix alloc] initWithWidth:(self.cellularView.bounds.size.width / CWYGridFactor) + 1
                                                            height:(self.cellularView.bounds.size.height / CWYGridFactor) + 1];
    
    
    [self setupMatrix];
    [self drawMatrix];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)nextGeneration:(id)sender
{
    [self.cellularView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.cellularMatrix nextGeneration];
    
    [self drawMatrix];
}

- (void)setupMatrix
{
    for (int matrixIndex = 0;
         matrixIndex < self.cellularMatrix.length;
         ++matrixIndex)
    {
        CALayer *layer = [[CALayer alloc] init];
        
        CGPoint point = [self.cellularMatrix pointFromVectorIndex:matrixIndex];
        layer.borderWidth = 0.0;
        layer.borderColor = [UIColor grayColor].CGColor;
        layer.frame = CGRectMake(point.x * CWYGridFactor,
                                 point.y * CWYGridFactor,
                                 CWYGridFactor,
                                 CWYGridFactor);
        
        layer.backgroundColor = [UIColor purpleColor].CGColor;
        layer.opacity = 0.0;
        layer.cornerRadius = CWYGridFactor / 2.0;
        [self.cellularView.layer addSublayer:layer];

    }
    
}

- (void)drawMatrix
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.5];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    for (int matrixIndex = 0;
         matrixIndex < self.cellularMatrix.length;
         ++matrixIndex)
    {
        
        CALayer *layer = self.cellularView.layer.sublayers[matrixIndex];
        
        if (self.cellularMatrix.currentMatrix[matrixIndex] == YES)
        {
            layer.opacity = 1.0;
            layer.bounds = CGRectMake(0.0, 0.0, CWYGridFactor, CWYGridFactor);

        }
        else
        {
            layer.opacity = 0.0;
            layer.bounds = CGRectMake(0.0, 0.0, 0.0, 0.0);
        }

    }
    [CATransaction commit];
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
    
    NSUInteger index = [self.cellularMatrix vectorIndexFromPointX:touchedPoint.x/CWYGridFactor

                                                           pointY:touchedPoint.y/CWYGridFactor];
    
    self.cellularMatrix.currentMatrix[index] = YES;
    
    NSLog(@"Point: %@", NSStringFromCGPoint(touchedPoint));

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self drawMatrix];
}

@end
