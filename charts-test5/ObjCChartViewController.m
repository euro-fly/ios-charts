//
//  ObjCChartViewController.m
//  charts-test5
//
//  Created by Jacob on 2018/06/07.
//  Copyright © 2018 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "charts_test5-Swift.h"
@import Charts;


@protocol GetChartData
- (void) getChartData: (NSArray*)dataPoints values:(NSArray*)b;
@end

@interface ObjCChartViewController :UIViewController <GetChartData>;
@end

@implementation ObjCChartViewController {
    NSArray* xAxis;
    NSArray* yAxis;
    NSArray* xAxisMonthly;
    NSArray *yAxisMonthly1;
    NSArray *yAxisMonthly2;
    NSArray* xAxisWeekly;
    NSArray* yAxisWeekly1;
    NSArray* yAxisWeekly2;
    NSArray* xAxisYearly;
    NSArray* yAxisYearly1;
    NSArray* yAxisYearly2;
    __weak IBOutlet LineChart *myLineChart;
    __weak IBOutlet UISegmentedControl *myButtonSet;
    __weak IBOutlet UILabel *weightLabel;
    __weak IBOutlet UILabel *fatLabel;
    __weak IBOutlet UIToolbar *rotateButton;
    __weak IBOutlet UIToolbar *updateButton;
}
- (IBAction)valueChanged:(id)sender {
    if (myButtonSet.selectedSegmentIndex == 0) {
        [self populateChartDataThree];
    } else if(myButtonSet.selectedSegmentIndex == 1) {
        [self populateChartData];
    } else if(myButtonSet.selectedSegmentIndex == 2) {
        [self populateChartDataTwo];
    } else {
    }
    [self refreshChart];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    xAxisMonthly = [[NSArray alloc] initWithObjects:@"29", @"28", @"27", @"26", @"25", @"24", @"23", @"22", @"21", @"20", @"19", @"18", @"17", @"16", @"15", @"14", @"13", @"12", @"11", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", @"1", @"0", nil];
    yAxisMonthly1 = [[NSArray alloc] initWithObjects: @"56.2", @"56.4", @"54.2", @"56.7", @"54.5", @"53.1", @"59.4", @"51", @"58", @"56", @"50", @"58", @"55", @"56", @"50", @"58", @"59", @"51", @"58", @"51", @"53", @"52", @"56", @"56", @"52", @"52", @"59", @"53", @"55", @"52", nil];
    yAxisMonthly2 = [[NSArray alloc] initWithObjects: @"23", @"26", @"29", @"28", @"25", @"28", @"21", @"24", @"22", @"26", @"22", @"23", @"21", @"23", @"22", @"22", @"29", @"22", @"26", @"22", @"22", @"23", @"20", @"23", @"28", @"25", @"24", @"24", @"27", @"24", nil];
    
    xAxisWeekly = [[NSArray alloc] initWithObjects:@"6", @"5", @"4", @"3", @"2", @"1", @"0", nil];
    yAxisWeekly1 = [[NSArray alloc] initWithObjects:@"54", @"52", @"52", @"54", @"57", @"57", @"50", nil];
    yAxisWeekly2 = [[NSArray alloc] initWithObjects:@"23", @"24", @"21", @"21", @"25", @"29", @"29", nil];
    
    xAxisYearly = [[NSArray alloc] initWithObjects:@"11", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", @"1", @"0", nil];
    yAxisYearly1 = [[NSArray alloc] initWithObjects:@"50", @"59", @"52", @"50", @"50", @"56", @"57", @"60.7", @"58", @"51", @"51", @"51", nil];
    yAxisYearly2 = [[NSArray alloc] initWithObjects:@"26", @"25", @"26", @"29", @"23", @"24", @"25", @"26", @"24", @"24", @"30", @"28", nil];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self.view addSubview:_myButton];
}

- (void) refreshChart {
    [myLineChart removeLimitLine];
    [self lineChart];
}

- (void) populateChartData {
    xAxis = xAxisMonthly;
    yAxis = [[NSArray init] initWithObjects:yAxisMonthly1, yAxisMonthly2, nil];
}

- (void) populateChartDataTwo {
    xAxis = xAxisWeekly;
    yAxis = [[NSArray init] initWithObjects:yAxisWeekly1, yAxisWeekly2, nil];
}

- (void) populateChartDataThree {
    xAxis = xAxisYearly;
    yAxis = [[NSArray init] initWithObjects:yAxisYearly1, yAxisYearly2, nil];
}

- (void) lineChart {
    
}
- (IBAction)rotate:(id)sender {
}

- (void) updateLabel: (NSString*)weight fat:(NSString*)fat {
    
}

- (IBAction)update:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getChartData: (NSArray*)dataPoints values:(NSArray*)values {
    
}


@end
