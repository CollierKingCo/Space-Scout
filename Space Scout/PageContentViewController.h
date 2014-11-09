//
//  PageContentViewController.h
//  Space Scout
//
//  Created by felix king on 28/10/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LanguageSelectionViewController.h"
#import "SpaceScoutHomePageViewController.h"
/*typedef NS_ENUM(NSInteger, lanagugeType) {
    lanagugeTypeLatin,
    lanagugeTypeEnglish,
    lanagugeTypeGerman,
    lanagugeTypeElvish,
    lanagugeTypeVolcan,
    lanagugeTypeSlyvan,
};*/


@interface PageContentViewController : UIViewController /*<UIPickerViewDataSource,UIPickerViewDelegate,*/<UIAlertViewDelegate, HomePageDelegate>
    
//-(IBAction)showdate:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)datePickerButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *datePickerButtonLabel;


@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *subTitleText;
@property NSString *imageFile;
@property NSString *buttonText;
@property NSString *adImageFile;
@property NSString *adText;
@property NSString *howToPlayImageFile;
@property NSString *howToPlayImageFile2;
@property NSString *dateLabelText;
@property (weak, nonatomic) IBOutlet UILabel *titleButtonLabel;
@property (weak, nonatomic) IBOutlet UILabel *LanguageLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *youChooseLabel;
@property (weak, nonatomic) IBOutlet UIImageView *adBannerImage;
@property (weak, nonatomic) IBOutlet UILabel *adLabel;
@property (weak, nonatomic) IBOutlet UIImageView *howToPlayImage;
@property (weak, nonatomic) IBOutlet UIImageView *howToPlay2Image;
- (IBAction)inAppPurchase:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *playButtonLabel;



@property NSInteger langugaeNum;
/*
@property (strong, nonatomic) NSArray *languageArray;

@property lanagugeType currentlySelectedLanguage;*/

@end
