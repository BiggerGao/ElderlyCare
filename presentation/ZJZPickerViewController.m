//
//  PickerViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/28.
//
//

#import "ZJZPickerViewController.h"
#import "GlobalVariablesManager.h"
#import "UIView+RGSize.h"

@interface ZJZPickerViewController ()

@property (strong, nonatomic) UIView *maskView;

@end

@implementation ZJZPickerViewController

// 数据懒加载
- (UIView*)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0;
        [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
    }
    return _maskView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pickerBgView.layer.cornerRadius = 10.0;
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
    }];
    NSInteger position = _dataList.count/2;
    [_pickerView selectRow:position inComponent:0 animated:NO];
    _chooseText = [NSString stringWithFormat:@"%@", _dataList[position]];
}

#pragma mark - private method
- (void)hideMyPicker
{
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBgView.top = self.view.height;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = [NSString stringWithFormat:@"%@", _dataList[row]];
    return title;
}

#pragma mark - delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _chooseText = [NSString stringWithFormat:@"%@", _dataList[row]];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submit:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(getTextStr:)]) {
        [_delegate getTextStr:_chooseText];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
