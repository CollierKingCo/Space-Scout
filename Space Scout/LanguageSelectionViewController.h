//
//  LanguageSelectionViewController.h
//  Space Scout
//
//  Created by felix king on 8/11/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SpaceScoutHomePageViewController.h"
#import "PageViewController.h"
#import "PageContentViewController.h"
typedef NS_ENUM(NSInteger, lanagugeType) {
    lanagugeTypeLatin,
    lanagugeTypeEnglish,
    lanagugeTypeGerman,
    lanagugeTypeElvish,
    lanagugeTypeVolcan,
    lanagugeTypeSlyvan,
};



@interface LanguageSelectionViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,ScrollPageDelegate> /*HomePageDelegate*/
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *langaugeLabel;
- (IBAction)selectorButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectorButtonLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *langaugePicker;


@property (strong, nonatomic) NSArray *languageArray;
@property (strong, nonatomic) NSArray *infoArray;

@property NSInteger infoCounter;

@property lanagugeType currentlySelectedLanguage;

@property NSInteger languageCounter;

@end
