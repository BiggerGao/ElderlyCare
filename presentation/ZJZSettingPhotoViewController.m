//
//  ZJZSettingPhotoViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/23.
//
//

#import "ZJZSettingPhotoViewController.h"
#import "ZJZKeeperDAO.h"
#import "Color-Tool.h"

@interface ZJZSettingPhotoViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UITextField *nicknameTxtField;

@end

@implementation ZJZSettingPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZJZColor(240, 240, 240, 1);
    self.navigationItem.title = @"注册3/3";
    [self createUI];
    [self createTextFiled];
}

- (void)createTextFiled {
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 270, self.view.frame.size.width, 50)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    _nicknameTxtField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 30)];
    _nicknameTxtField.placeholder = @"请输入昵称";
    _nicknameTxtField.textAlignment = NSTextAlignmentCenter;
    _nicknameTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_bgView addSubview:_nicknameTxtField];
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    finishButton.frame = CGRectMake(10, _bgView.frame.origin.y + _bgView.frame.size.height + 30, self.view.bounds.size.width - 20, 37);
    finishButton.backgroundColor = ZJZColor(213, 54, 65, 1);
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    finishButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishButton setTintColor:[UIColor whiteColor]];
    finishButton.layer.cornerRadius = 5.0;
    [finishButton addTarget:self action:@selector(postKeeper) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:finishButton];
}

- (void)createUI {
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250)];
    bg.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bg];
    
    _photoButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 40, 110, 80, 80)];
    _photoButton.layer.cornerRadius = 40;
    _photoButton.layer.masksToBounds = YES;
    _photoButton.backgroundColor = [UIColor whiteColor];
    [_photoButton addTarget:self action:@selector(changePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_photoButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 40, 180, 80, 80)];
    label.text = @"点击设置头像";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
}

- (void)changePhoto:(UIButton *)tag {
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"更改图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册上传", nil];
    menu.delegate = self;
    menu.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [menu showInView:self.view];
}

#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //0->拍照,1->相册
    if (buttonIndex == 0) {
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self choosePhoto];
    }
}

- (void)takePhoto {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        __block UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        ipc.allowsEditing = YES;
        ipc.navigationBar.barTintColor = [UIColor whiteColor];
        ipc.navigationBar.tintColor = [UIColor whiteColor];
        ipc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        [self presentViewController:ipc animated:YES completion:^{
            ipc = nil;
        }];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败"
                                                            message:@"无法打开照相机"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)choosePhoto {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        __block UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.delegate = self;
        
        ipc.allowsEditing = YES;
        ipc.navigationBar.barTintColor = [UIColor whiteColor];
        ipc.navigationBar.tintColor = [UIColor whiteColor];
        ipc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
        [self presentViewController:ipc animated:YES completion:nil];
    }
}

#pragma mark - ImagePickerControllerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //NSLog(@"type:%@",type);
    if ([type isEqualToString:@"public.image"]) {
        //转换成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            //上传头像
            if ([self saveImage:image]) {
                //设置头像
                [_photoButton setImage:image forState:UIControlStateNormal];
            }
        }];
        
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 保存图片到本地Document
- (BOOL)saveImage:(UIImage *)image {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSMutableString *savePath = [NSMutableString stringWithFormat:@"Keeper/%@",_registerKeeper.tel];
    NSString *keeperPath = [documentPath stringByAppendingPathComponent:savePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:keeperPath isDirectory:&isDir];
    
    if (!(isDir && existed)) {
        [fileManager createDirectoryAtPath:keeperPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [savePath appendString:@"/photo"];
    NSString *filePath = [documentPath stringByAppendingPathComponent:savePath];
    NSLog(@"%@", filePath);
    // 如果没有文件夹，创建文件夹

    if (![UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    };
    _registerKeeper.photoPath = savePath;
    return YES;
}

#pragma mark - post Keeper
- (void)postKeeper {
    NSString *temp = [_nicknameTxtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([temp isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败"
                                                            message:@"昵称不能为空"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    if (!_photoButton.imageView.image) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败"
                                                            message:@"未上传头像"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    _registerKeeper.nickname = _nicknameTxtField.text;
    ZJZKeeperDAO *keeperDAO = [ZJZKeeperDAO sharedManager];
    keeperDAO.registerDelegate = self;
    [[ZJZKeeperDAO sharedManager] addKeeper:_registerKeeper];
}

// 注册完成
- (void)completeRegister
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"成功"
                                                        message:@"注册完成"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    [alertView show];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// 注册失败，用户存在
- (void)keeperAlreadyExist
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败"
                                                        message:@"用户已经存在"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
