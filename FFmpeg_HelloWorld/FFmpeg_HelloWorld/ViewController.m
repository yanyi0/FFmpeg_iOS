//
//  ViewController.m
//  FFmpeg_HelloWorld
//
//  Created by Cloud on 2021/7/18.
//

#import "ViewController.h"
#import "avformat.h"
#import "avcodec.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    av_register_all();
    char *s = av_version_info();
    printf("%s\n",s);
    // Do any additional setup after loading the view.
}


@end
