//
//  PickerViewController.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/28.
//
//

#import <UIKit/UIKit.h>
@protocol ZJZPickViewDelegate <NSObject>
- (void)getTextStr:(NSString *)text;
@end

@interface ZJZPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, unsafe_unretained) id<ZJZPickViewDelegate> delegate;

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSString *chooseText;
@property (strong, nonatomic) IBOutlet UIView *pickerBgView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end
