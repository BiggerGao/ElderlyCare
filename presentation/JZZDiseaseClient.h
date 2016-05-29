//
//  JZZDiseaseClient.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/27.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface JZZDiseaseClient : NSObject

- (RACSignal *)fetchAllDiseaseMessageFromURL:(NSURL *)url;

@end
