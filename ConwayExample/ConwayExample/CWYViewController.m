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

@property (nonatomic, strong) CWYCelullarMatrix *cellularMatrix;

@end

@implementation CWYViewController

- (void)viewDidLoad
{
    self.cellularMatrix = [[CWYCelullarMatrix alloc] initWithWidth:self.view.bounds.size.width+1
                                                            height:self.view.bounds.size.height+1];
    
    [self drawMatrix];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
            
            [self.view addSubview:viewTest];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
