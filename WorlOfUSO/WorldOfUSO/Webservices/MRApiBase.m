//
//  MRApiBase.m
//  ActeAz
//
//  Created by Andrei Vaduva on 6/17/14.
//  Copyright (c) 2014 mReady. All rights reserved.
//

#import "MRApiBase.h"

#import "AFNetworking.h"
#import "TDOAuth.h"

static NSString *consumerKey = @"key";
static NSString *consumerSecret = @"secret";
static NSString *wousoHost = @"wouso.cs.pub.ro/next/api/";

@interface MRApiBase() {
    NSString *accessToken;
    NSString *tokenSecret;
}

@end

@implementation MRApiBase

- (id)init {
    self = [super init];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    accessToken = [userDefaults objectForKey:@"oauth_token"];
    tokenSecret = [userDefaults objectForKey:@"oauth_token_secret"];
    
    return self;
}

- (void)doGETRequest:(NSString *)requestPath withParameters:(NSDictionary *)params
             success:(void (^)(id responseObject))success
             failure:(void (^) (NSError *err))failure {
    NSURLRequest * rq = [TDOAuth URLRequestForPath:requestPath GETParameters:params host:wousoHost consumerKey:consumerKey consumerSecret:consumerSecret accessToken:accessToken tokenSecret:tokenSecret];
    
    [NSURLConnection sendAsynchronousRequest:rq queue:nil completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            NSError *error;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (!json && error && [error.domain isEqualToString:NSCocoaErrorDomain] && (error.code == NSPropertyListReadCorruptError)) {
                // Encoding issue, try Latin-1
                NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
                if (jsonString) {
                    // Need to re-encode as UTF8 to parse, thanks Apple
                    json = [NSJSONSerialization JSONObjectWithData:
                            [jsonString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]
                                                           options:0 error:&error];
                }
            }
            
            success(json);
        } else {
            failure(connectionError);
        }
    }];
}

- (void)doPOSTReques:(NSString *)requestPath withParameters:(NSMutableDictionary *)params
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSError *err))failure {
    NSURLRequest * rq = [TDOAuth URLRequestForPath:requestPath POSTParameters:params host:wousoHost consumerKey:consumerKey consumerSecret:consumerSecret accessToken:accessToken tokenSecret:tokenSecret];
    
    [NSURLConnection sendAsynchronousRequest:rq queue:nil completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            NSError *error;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (!json && error && [error.domain isEqualToString:NSCocoaErrorDomain] && (error.code == NSPropertyListReadCorruptError)) {
                // Encoding issue, try Latin-1
                NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
                if (jsonString) {
                    // Need to re-encode as UTF8 to parse, thanks Apple
                    json = [NSJSONSerialization JSONObjectWithData:
                            [jsonString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]
                                                           options:0 error:&error];
                }
            }
            
            success(json);
        } else {
            failure(connectionError);
        }
    }];
}

- (void)requestImage:(NSString *)requestURL
             withSuccess:(void (^)(id responseObject))success
             andFailure:(void (^)(NSError *error))failure {
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
    [requestOperation start];
}
@end