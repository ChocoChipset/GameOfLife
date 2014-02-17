//
//  CWYViewController.m
//  ConwayExample
//
//  Created by Hector Zarate on 2/15/14.
//  Copyright (c) 2014 Hector Zarate. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "CWYViewController.h"
#import "CWYCellularMatrix.h"

const NSUInteger CWYGridFactor = 8;
const NSTimeInterval CWYAnimationTimeInterval = 0.75; // [s]


@interface CWYViewController ()

@property (nonatomic, weak) NSTimer *animationTimer;

@property (nonatomic, strong) IBOutlet UIView *cellularView;
@property (nonatomic, strong) CWYCellularMatrix *cellularMatrix;

-(IBAction)handleAnimationButtonPress:(id)sender;

-(void)displayNextGenerationOfMatrix;

@end

@implementation CWYViewController

- (void)viewDidLoad
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapGesture:)];
    tapGestureRecognizer.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.cellularMatrix = [[CWYCellularMatrix alloc] initWithWidth:(self.cellularView.bounds.size.width / CWYGridFactor) + 1
                                                            height:(self.cellularView.bounds.size.height / CWYGridFactor) + 1];
    
    
    [self setupMatrix];
    
    [super viewDidLoad];
}


#pragma mark - IBActions


- (void)handleDoubleTapGesture:(UITapGestureRecognizer *)paramTapGestureRecognizer
{
    [self.cellularMatrix clearCurrentMatrix];
    [self drawMatrix];
}

-(IBAction)handleAnimationButtonPress:(UIButton *)sender
{
    if (self.animationTimer)
    {
        [sender setTitle:@"Start Animation" forState:UIControlStateNormal];
        [self.animationTimer invalidate];
    }
    else
    {
        [sender setTitle:@"Stop Animation" forState:UIControlStateNormal];
        [self displayNextGenerationOfMatrix];
        
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:CWYAnimationTimeInterval
                                                               target:self
                                                             selector:@selector(displayNextGenerationOfMatrix)
                                                             userInfo:Nil
                                                              repeats:YES];
    }
}


#pragma mark - Matrix


-(void)displayNextGenerationOfMatrix
{
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
        
        layer.backgroundColor = [UIColor colorWithRed:1.0
                                                green:0.6
                                                 blue:0.0
                                                alpha:1.0].CGColor;
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


#pragma mark - Touch Handling


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
