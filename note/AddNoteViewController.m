//
//  AddNoteViewController.m
//  note
//
//  Created by  李俊 on 15/6/9.
//  Copyright (c) 2015年  李俊. All rights reserved.
//

#import "AddNoteViewController.h"
#import "Note.h"
#import "Masonry.h"

@interface AddNoteViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation AddNoteViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.textView.superview.mas_top).offset(10);
//        make.left.mas_equalTo(self.textView.superview.mas_left).offset(10);
//        make.right.mas_equalTo(self.textView.superview.mas_right).offset(-10);
//        make.bottom.mas_equalTo(self.textView.superview.mas_bottom).offset(-10);
//        
//    }];
    
    self.textView.delegate = self;
    [self.textView becomeFirstResponder];

    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(changeKeyboard:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM月dd日";
    
    NSString *dateS = [formatter stringFromDate:date];
    
    self.navigationItem.title = dateS;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.textView endEditing:YES];
    
    self.note.text = self.textView.text;
    
}

- (void)changeKeyboard:(NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    
    CGFloat keyboardY = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(keyboardY - [UIScreen mainScreen].bounds.size.height - 10);
    }];
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
