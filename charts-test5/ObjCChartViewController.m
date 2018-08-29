//
//  ObjCChartViewController.m
//  charts-test5
//
//  Created by Jacob on 2018/06/07.
//  Copyright © 2018 Jacob. All rights reserved.
//


@import Charts;
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "charts_test5-Swift.h"



@protocol getChartData2

@property NSMutableArray* xAxis;
@property NSMutableArray* yAxis;

- (void) getChartData: (NSMutableArray*)dataPoints values:(NSMutableArray*)values;
@end

@interface ObjCChartViewController :UIViewController <getChartData2>;
@end

@implementation ObjCChartViewController {
    NSMutableArray* xAxisMonthly;
    NSMutableArray* yAxisMonthly1;
    NSMutableArray* yAxisMonthly2;
    NSMutableArray* xAxisWeekly;
    NSMutableArray* yAxisWeekly1;
    NSMutableArray* yAxisWeekly2;
    NSMutableArray* xAxisYearly;
    NSMutableArray* yAxisYearly1;
    NSMutableArray* yAxisYearly2;
    NSMutableArray* xAxisAllTime;
    NSMutableArray* yAxisAllTime1;
    NSMutableArray* yAxisAllTime2;
    
    __weak IBOutlet LineChart *myLineChart;
    __weak IBOutlet UISegmentedControl *myButtonSet;
    __weak IBOutlet UILabel *weightLabel;
    __weak IBOutlet UILabel *fatLabel;
    __weak IBOutlet UIButton *rotateButton;
    
    __weak IBOutlet UIToolbar *toolbar;
    __weak IBOutlet UIButton *updateButton;
}
- (IBAction)valueChanged:(id)sender {
    if (myButtonSet.selectedSegmentIndex == 0) {
        [self populateChartDataThree];
    } else if(myButtonSet.selectedSegmentIndex == 1) {
        [self populateChartData];
    } else if(myButtonSet.selectedSegmentIndex == 2) {
        [self populateChartDataTwo];
    } else {
        [self populateChartDataFour];
    }
    [self refreshChart];
}
- (IBAction)rotate:(id)sender {
    if (UIDeviceOrientationIsPortrait(UIDevice.currentDevice.orientation)) {
        [UIDevice.currentDevice setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    }
    else {
        [UIDevice.currentDevice setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    }
}
- (IBAction)update:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Update"
                                                                              message: @"Weight and Body Fat"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Weight";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Bodyfat";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * bodyWeight = textfields[0];
        UITextField * bodyFat = textfields[1];
        NSLog(@"%@:%@",bodyWeight.text,bodyFat.text);
        NSPredicate *predicate;
        predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '^[-+]?[0-9]*\.?[0-9]+$'"];
        BOOL result1 = [predicate evaluateWithObject:bodyWeight.text];
        BOOL result2 = [predicate evaluateWithObject:bodyFat.text];
        if (result1) {
            self.yAxis[0][self.xAxis.count - 1] = bodyWeight.text;
        }
        if (result2) {
            self.yAxis[1][self.xAxis.count - 1] = bodyFat.text;
        }
        if (!(!result1 && !result2)) {
            [self getChartData:self.xAxis values:self.yAxis];
            [self refreshChart];
        }                                                                                       
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    xAxisMonthly = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", nil];
    yAxisMonthly1 = [[NSMutableArray alloc] initWithObjects: @"56.2", @"56.4", @"54.2", @"56.7", @"54.5", @"53.1", @"59.4", @"51", @"58", @"56", @"50", @"58", @"55", @"56", @"50", @"58", @"59", @"51", @"58", @"51", @"53", @"52", @"56", @"56", @"52", @"52", @"59", @"53", @"55", @"52", nil];
    yAxisMonthly2 = [[NSMutableArray alloc] initWithObjects: @"23", @"26", @"29", @"28", @"25", @"28", @"21", @"24", @"22", @"26", @"22", @"23", @"21", @"23", @"22", @"22", @"29", @"22", @"26", @"22", @"22", @"23", @"20", @"23", @"28", @"25", @"24", @"24", @"27", @"24", nil];
    
    xAxisWeekly = [[NSMutableArray alloc] initWithObjects:@"6", @"5", @"4", @"3", @"2", @"1", @"0", nil];
    yAxisWeekly1 = [[NSMutableArray alloc] initWithObjects:@"54", @"52", @"52", @"54", @"57", @"57", @"50", nil];
    yAxisWeekly2 = [[NSMutableArray alloc] initWithObjects:@"23", @"24", @"21", @"21", @"25", @"29", @"29", nil];
    
    xAxisYearly = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", nil];
    yAxisYearly1 = [[NSMutableArray alloc] initWithObjects:@"50", @"59", @"52", @"50", @"50", @"56", @"57", @"60.7", @"58", @"51", @"51", @"51", nil];
    yAxisYearly2 = [[NSMutableArray alloc] initWithObjects:@"26", @"25", @"26", @"29", @"23", @"24", @"25", @"26", @"24", @"24", @"30", @"28", nil];
    
    xAxisAllTime = [[NSMutableArray alloc] initWithObjects:@"1", @"0", nil];
    yAxisAllTime1 = [[NSMutableArray alloc] initWithObjects:@"57", @"50", nil];
    yAxisAllTime2 = [[NSMutableArray alloc] initWithObjects:@"29", @"23", nil];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self.view addSubview:_myButton];
    
    [self.view addSubview:myLineChart];
    [self.view addSubview:toolbar];
    [toolbar addSubview:rotateButton];
    [toolbar addSubview:updateButton];
    [self populateChartDataThree];
    [self lineChart];
}

- (void) refreshChart {
    [myLineChart removeLimitLine];
    [self lineChart];
}

- (void) populateChartData {
    xAxis = xAxisMonthly;
    yAxis = [[NSMutableArray alloc] initWithObjects:yAxisMonthly1, yAxisMonthly2, nil];
    [self getChartData:xAxis values:yAxis];
}

- (void) populateChartDataTwo {
    xAxis = xAxisWeekly;
    yAxis = [[NSMutableArray alloc] initWithObjects:yAxisWeekly1, yAxisWeekly2, nil];
    [self getChartData:xAxis values:yAxis];
}

- (void) populateChartDataThree {
    xAxis = xAxisYearly;
    yAxis = [[NSMutableArray alloc] initWithObjects:yAxisYearly1, yAxisYearly2, nil];
    [self getChartData:xAxis values:yAxis];
}

- (void) populateChartDataFour {
    xAxis = xAxisAllTime;
    yAxis = [[NSMutableArray alloc] initWithObjects:yAxisAllTime1, yAxisAllTime2, nil];
}

- (void) lineChart {
    myLineChart.delegate = self;
    BalloonMarker *marker = [[BalloonMarker alloc] initWithColor:UIColor.blackColor font:[UIFont fontWithName:@"Helvetica" size:12.0] textColor:UIColor.blackColor insets:UIEdgeInsetsZero];
    marker.minimumSize = CGSizeMake(1.0, 35.0);
    myLineChart.lineChartView.marker = marker;
    marker.chartView = myLineChart.lineChartView;
    marker.chartViewController = self;
    
    
}

- (void) updateLabel: (NSString*)weight fat:(NSString*)fat {
    weightLabel.text = weight;
    fatLabel.text = fat;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getChartData: (NSMutableArray*)dataPoints values:(NSMutableArray*)values {
    self.xAxis = dataPoints;
    self.yAxis = values;
}



@synthesize xAxis;

@synthesize yAxis;

@end
