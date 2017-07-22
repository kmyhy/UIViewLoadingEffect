//
//  dimessions.h
//  Client
//
//  Created by qq on 2016/11/24.
//  Copyright © 2016年 qq. All rights reserved.
//

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_SCALE [[UIScreen mainScreen] scale]
#define iPhoneSE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define MAX_IMAGE_SIZE CGSizeMake(1800,1800)
