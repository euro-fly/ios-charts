//
//  ObjCChartViewController.h
//  charts-test5
//
//  Created by Jacob on 2018/06/07.
//  Copyright © 2018 Jacob. All rights reserved.
//

#ifndef ObjCChartViewController_h
#define ObjCChartViewController_h


#endif /* ObjCChartViewController_h */

#import <Foundation/Foundation.h>
@import Charts;
#import <UIKit/UIKit.h>

@protocol getChartData2
@property NSArray* xAxis;
@property NSArray* yAxis;
- (void) getChartData: (NSArray*)dataPoints values:(NSArray*)values;
@end

@interface ObjCChartViewController : UIViewController <getChartData2>;
- (void) updateLabel: (NSString*)weight fat:(NSString*)fat;
@end
