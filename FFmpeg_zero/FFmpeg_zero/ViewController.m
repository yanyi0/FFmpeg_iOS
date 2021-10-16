//
//  ViewController.m
//  FFmpeg_zero
//
//  Created by Cloud on 2021/10/17.
//

#import "ViewController.h"
#import "avcodec.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    avcodec_register_all();
    char *s = av_version_info();
    printf("%s\n",s);
    // Do any additional setup after loading the view.
}


@end
