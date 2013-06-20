//
//  ViewController.m
//  ComposingImagesTest
//
//  Created by Genesislive on 6/20/13.
//  Copyright (c) 2013 Genesislive. All rights reserved.
//

#import "ViewController.h"
#import "CustomJigSawView.h"

#define kPicsInView 6

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initJigSawView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initJigSawView
{
    CGRect jigSawViewRect;
    jigSawViewRect = CGRectMake(15, 20, 290, 420);
    
    //init JSPicsType is not neccessary because when u set 
    CustomJigSawView * _JigSawView = [[CustomJigSawView alloc] initWithFrame:jigSawViewRect andJigSawViewType:JSPicsType1];
    
    _JigSawView.layer.shadowColor = [UIColor blackColor].CGColor;
    _JigSawView.layer.shadowOffset = CGSizeMake(0, 1);
    _JigSawView.layer.shadowOpacity = 0.8;
    _JigSawView.layer.shadowRadius = 2.5;
    
    self.mainJigSawView = _JigSawView;
    
    [self.view addSubview:self.mainJigSawView];
    
    [self updateJigSawView];
}


-(void)updateJigSawView
{
    switch (kPicsInView ) {
        case 1:
            self.mainJigSawView.jsViewType = JSPicsType1;
            break;
        case 2:
            self.mainJigSawView.jsViewType = JSPicsType3;
            break;
        case 3:
            self.self.mainJigSawView.jsViewType = JSPicsType5;
            break;
        case 4:
            self.mainJigSawView.jsViewType = JSPicsType7;
            break;
        case 5:
            self.mainJigSawView.jsViewType = JSPicsType9;
            break;
        case 6:
            self.mainJigSawView.jsViewType = JSPicsType10;
            break;
        default:
            break;
    }
    for (int i = 0; i<kPicsInView; i++) {
        
        JigSawViewCell *jsCell = [self.mainJigSawView.viewCellsArray objectAtIndex:i];
        jsCell.selfImage = [UIImage imageNamed:[NSString stringWithFormat:@"imageP%d",i+1]];
        
    }
    [self.mainJigSawView changePositionWithAnimation];

}
//-(void)resetJigSawViewCellNum
//{
//    int photosNum = [self.imageSelectionC.selectedPhotos count];
//    if (photosNum == 1&& self.mainJigSawView.JigSawViewTypeNum>1) {
//        self.mainJigSawView.jsViewType = JSPicsType1;
//    }else
//        if (photosNum == 2 && self.mainJigSawView.JigSawViewTypeNum>3) {
//            if (!([self.mainJigSawView getJigSaaViewType] == JSPicsType2 || [self.mainJigSawView getJigSaaViewType] == JSPicsType3)) {
//                self.mainJigSawView.jsViewType = JSPicsType2;
//            }
//        }else
//            if (photosNum == 3 && self.mainJigSawView.JigSawViewTypeNum>5) {
//                if (!([self.mainJigSawView getJigSaaViewType] == JSPicsType4 || [self.mainJigSawView getJigSaaViewType] == JSPicsType5)) {
//                    self.mainJigSawView.jsViewType = JSPicsType4;
//                }
//            }else
//                if (photosNum == 4 && self.mainJigSawView.JigSawViewTypeNum>7) {
//                    if (!([self.mainJigSawView getJigSaaViewType] == JSPicsType6 || [self.mainJigSawView getJigSaaViewType] == JSPicsType7)) {
//                        self.mainJigSawView.jsViewType = JSPicsType6;
//                    }
//                }else
//                    if (photosNum == 5 && self.mainJigSawView.JigSawViewTypeNum>9) {
//                        if (!([self.mainJigSawView getJigSaaViewType] == JSPicsType8 || [self.mainJigSawView getJigSaaViewType] == JSPicsType9)) {
//                            self.mainJigSawView.jsViewType = JSPicsType8;
//                        }
//                    }else
//                        if(photosNum == 6 && self.mainJigSawView.JigSawViewTypeNum>11){
//                            if (!([self.mainJigSawView getJigSaaViewType] == JSPicsType10 || [self.mainJigSawView getJigSaaViewType] == JSPicsType11)) {
//                                self.mainJigSawView.jsViewType = JSPicsType10;
//                            }
//                        }
//    
////    [self reloadImageForJigCells];
//}

@end
