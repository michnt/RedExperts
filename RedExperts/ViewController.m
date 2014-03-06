//
//  ViewController.m
//  RedExperts
//
//  Created by Artur Michna on 04.03.2014.
//  Copyright (c) 2014 Artur Michna. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()


@end

@implementation ViewController
@synthesize myLocationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getDataButton:(id)sender
{
    NSString *websiteURL = @"https://dl.dropboxusercontent.com/u/6556265/test.json";
    NSURL *url = [NSURL URLWithString:websiteURL]; // convert string to URL
    
    
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:NULL];
    
  //  NSLog(@"%@",json);
  //  NSLog(@"%@",[json objectForKey:@"location"]);
    
    NSNumber *latitude = [[json objectForKey:@"location"] objectForKey:@"latitude"];
    NSNumber *longitude = [[json objectForKey:@"location"] objectForKey:@"longitude"];
    self.pinLabel.text = [NSString stringWithFormat:@"%@ %@", latitude,longitude];
    _secondLocation = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
    

    NSArray *locationArray = [NSArray arrayWithObjects:[json objectForKey:@"location"],[json objectForKey:@"text"],[json objectForKey:@"image"], nil];
    // NSLog(@"%@",locationArray);
    
    
    self.showDataLabel.text = [NSString stringWithFormat:@"%@", locationArray];

    
    // localization
    
    if ([CLLocationManager locationServicesEnabled]){
        self.myLocationManager = [[CLLocationManager alloc] init];
        self.myLocationManager.delegate = self;
        
        [self.myLocationManager startUpdatingLocation];
    } else {
        NSLog(@"Włącz lokalizację w ustawieniach urządzenia");
    }
    
    
    NSURL *imageURL = [NSURL URLWithString:[json objectForKey:@"image"]];
    NSData *imageLink = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageLink];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    [imgView setFrame:CGRectMake(100, 390, 300, 80)];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];
    
}



- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *myLocation = [locations lastObject];
    // NSLog(@"%g",myLocation.coordinate.latitude);
   //  NSLog(@"%g",myLocation.coordinate.longitude);
    
    double latitude = myLocation.coordinate.latitude;
    double longitude = myLocation.coordinate.longitude;
    
    NSString *myLocationString = [NSString stringWithFormat:@"%f %f",latitude , longitude];
    self.yourPositionLabel.text = myLocationString;
    

    _firstLocation =[[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    [self calculateDistanceWithLatitude:_firstLocation andLongitude:_secondLocation];
    
}

- (void) calculateDistanceWithLatitude: (CLLocation *)fLocation andLongitude: (CLLocation *)sLocation
{
    CLLocationDistance distance = [fLocation distanceFromLocation:sLocation];
    // NSLog(@"%f",distance);
    NSString *stringDistance = [NSString stringWithFormat:@"%f",distance / 1000];
    self.distanceLabel.text = stringDistance;
}


@end
