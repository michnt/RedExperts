//
//  ViewController.h
//  RedExperts
//
//  Created by Artur Michna on 04.03.2014.
//  Copyright (c) 2014 Artur Michna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

- (IBAction)getDataButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *showDataLabel;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *yourPositionLabel;
@property (strong, nonatomic) IBOutlet UILabel *pinLabel;

@property (nonatomic, strong) CLGeocoder *myGeocoder;
@property (nonatomic,strong) CLLocationManager *myLocationManager;


@property CLLocation *firstLocation;
@property CLLocation *secondLocation;

@end
