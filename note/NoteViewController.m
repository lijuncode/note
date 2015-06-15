//
//  NoteViewController.m
//  note
//
//  Created by  李俊 on 15/6/7.
//  Copyright (c) 2015年  李俊. All rights reserved.
//

#import "NoteViewController.h"
#import "Note.h"
#import "Masonry.h"

@interface NoteViewController ()<UITextViewDelegate>

@property (weak, nonatomic) UITextView *textView;

@property ( nonatomic) CGFloat oldContantY;

@property ( nonatomic) float font;

@end

@implementation NoteViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
//    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    
//    [self.view addSubview:view];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextView *textView = [[UITextView alloc] init];
    [self.view addSubview:textView];
//    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textView.superview.mas_top).offset(10);
        make.left.mas_equalTo(textView.superview.mas_left).offset(10);
        make.right.mas_equalTo(textView.superview.mas_right).offset(-10);
        make.bottom.mas_equalTo(textView.superview.mas_bottom).offset(-10);
    }];
//    textView.frame = CGRectMake(10, 10, 300, 548);
    
    //    textView.backgroundColor = [UIColor grayColor];
    self.textView = textView;
    textView.text = self.note.text;
    self.font = 16;
    textView.font = [UIFont systemFontOfSize:self.font];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completeInPut)];
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *bigFont = [[UIBarButtonItem alloc] initWithTitle:@"A+" style:UIBarButtonItemStylePlain target:self action:@selector(bigFont)];
    
     UIBarButtonItem *smallFont = [[UIBarButtonItem alloc] initWithTitle:@"A-" style:UIBarButtonItemStylePlain target:self action:@selector(smallFont)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    spaceItem.width = 20;
    
    toolbar.items = @[flexibleItem,smallFont,spaceItem,bigFont,spaceItem,done,spaceItem];
    
    self.textView.inputAccessoryView = toolbar;
    
    self.textView.delegate = self;
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(changeKeyboard:) name:UIKeyboardWillChangeFrameNotification object:nil];
  
    
}
- (void)smallFont{
    
    self.font -= 2;
    
    self.textView.font = [UIFont systemFontOfSize:self.font];
    
}

- (void)bigFont{
    
    self.font += 2;
    
    self.textView.font = [UIFont systemFontOfSize:self.font];
    
}

- (void)completeInPut{
    
    [self.view endEditing:YES];
    
}

- (void)hiddenKeyboard{
    
    [self.textView endEditing:YES];
    

    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
//    Note *note = self.note;
    
    self.note.text = self.textView.text;
    
}
/**
 *   *
 *  @param notification <#notification description#>
 */
- (void)changeKeyboard:(NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    
    CGFloat keyboardY = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
   [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
       make.bottom.mas_equalTo(self.view.mas_bottom).offset(keyboardY - [UIScreen mainScreen].bounds.size.height - 10);
   }];
    

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.oldContantY = scrollView.contentOffset.y;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > self.oldContantY) {
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    }else if (scrollView.contentOffset.y < self.oldContantY){

         [self.navigationController setNavigationBarHidden:NO animated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
