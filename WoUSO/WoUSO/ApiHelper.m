//
//  ApiHelper.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 11/04/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "ApiHelper.h"
#import "TDOAuth.h"

@implementation ApiHelper
@synthesize token;

-(id)init {
    self = [super init];
    NSUserDefaults * userDefaults = [[NSUserDefaults alloc] init];
    token = [userDefaults objectForKey:@"oauth_token"];
    self.tokenSecret = [userDefaults objectForKey:@"oauth_token_secret"];
    return self;
}

-(NSData *) makeGETRequest:(NSString *) content GETParameters:(NSMutableDictionary *)dict
{
//    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
  //  [dict2 setObject:self.token forKey:@"oauth_token"];
   // [dict setObject:@"key" forKey:@"oauth_consumer_key"];
    NSURLRequest * rq = [TDOAuth URLRequestForPath:content GETParameters:dict host:wousoHost consumerKey:key consumerSecret:secret accessToken:token tokenSecret:self.tokenSecret];
    NSError *requestError;
    NSURLResponse* response;
    NSData * d = [NSURLConnection sendSynchronousRequest:rq returningResponse:&response error:&requestError];
    return d;
}

-(NSData *)makePOSTRequest:(NSString *) content POSTParameters:(NSMutableDictionary *)dict
{
    NSURLRequest * rq = [TDOAuth URLRequestForPath:content POSTParameters:dict host:@"wouso.cs.pub.ro/next/api" consumerKey:key consumerSecret:secret accessToken:token tokenSecret:self.tokenSecret];
    NSError * requestError;
    NSURLResponse * response;
    NSData * d = [NSURLConnection sendSynchronousRequest:rq returningResponse:&response error:&requestError];
    return d;
}

-(NSDictionary*)makeGETRequest:(NSString*)content
{
    NSData * data;
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    data = [self makeGETRequest:content GETParameters:dict];
    NSDictionary * jsonResponse;
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
    return json;
}

-(UIImage *)getImageForURL:(NSString *)imgUrl
{
    NSError * error;
    NSURLRequest * rq = [NSURLRequest requestWithURL:[NSURL URLWithString:imgUrl]];
    NSData *picture = [NSURLConnection sendSynchronousRequest:rq returningResponse:nil error:&error];
    UIImage * img = [UIImage imageWithData:picture];
    return img;
}

-(NSDictionary *)getUserInfo
{
    return [self makeGETRequest:@"info/"];
}

-(NSDictionary *)getAvailableSpells
{
    return [self makeGETRequest:@"bazaar/"];
}

-(NSDictionary *)getInventorySpells
{
    return [self makeGETRequest:@"bazaar/inventory/"];
}

-(BOOL)buySpell:(NSString *)spellId
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:spellId forKey:@"spell"];
    NSData * data;
    data = [self makePOSTRequest:@"/bazaar/buy/" POSTParameters:params];
    NSDictionary * jsonResponse;
    jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return [[jsonResponse objectForKey:@"success"] boolValue];
}

-(BOOL)sendMessage:(NSString*)message toReceiver:(NSString*)receiver withSubject:(NSString*)subject
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:receiver forKey:@"receiver"];
    [params setObject:message forKey:@"text"];
    if (subject != nil)
        [params setObject:subject forKey:@"subject"];
    NSData * replyData = [self makePOSTRequest:@"/messages/send/" POSTParameters:params];
    NSDictionary * json;
    json = [NSJSONSerialization JSONObjectWithData:replyData options:NSJSONReadingMutableLeaves error:nil];
    return [[json objectForKey:@"success"] boolValue];
}

-(NSArray *)getTopRaces
{
    return [self makeGETRequest:@"top/race/"];
}

-(NSDictionary *)getUserInfo:(NSString *)userId
{
    return [self makeGETRequest:[NSString stringWithFormat:@"player/%@/info/", userId]];
}

-(NSDictionary *)getTopGroupsInRace:(NSString *)raceId
{
    NSString * getURL = [NSString stringWithFormat:@"top/race/%@/group/", raceId];
    return [self makeGETRequest:getURL];
}

-(NSDictionary *)getTopUsersInRace:(NSString *)raceId
{
    NSString *getURL = [NSString stringWithFormat:@"top/race/%@/player/", raceId];
    return [self makeGETRequest:getURL];
}

-(NSArray *)getTopGroups
{
    return [self makeGETRequest:@"top/group/"];
}

-(NSDictionary *)getTopPlayersInGroup:(NSString *)groupId
{
    NSString * getURL = [NSString stringWithFormat:@"top/group/%@/player", groupId];
    return [self makeGETRequest:getURL];
}

-(NSArray *)getTopPlayers
{
    return  [self makeGETRequest:@"top/player/"];
}

-(NSDictionary *)getAllRaces
{
    return [self makeGETRequest:@"race/"];
}

-(NSDictionary *)getAllGroups
{
    return [self makeGETRequest:@"group/"];
}

-(NSDictionary *)getPlayersInRace:(NSString*)raceId
{
    NSString * getURL = [NSString stringWithFormat:@"race/%@/members/", raceId];
    return [self makeGETRequest:getURL];
}

-(NSDictionary *)getGroupsInRace:(NSString*)raceId
{
    NSString *getURL = [NSString stringWithFormat:@"race/%@/groups/", raceId];
    return [self makeGETRequest:getURL];
}

-(NSDictionary *)getGroupInfo:(NSString*)groupId
{
    NSString *getURL = [NSString stringWithFormat:@"group/%@/", groupId];
    return  [self makeGETRequest:getURL];
}

-(NSDictionary *)getGroupMembers:(NSString *)groupId
{
    NSString * getURL = [NSString stringWithFormat:@"group/%@/members/", groupId];
    return [self makeGETRequest:getURL];
}

-(NSDictionary *)getGroupActivity:(NSString*)groupId
{
    NSString * getURL = [NSString stringWithFormat:@"group/%@/activity/", groupId];
    return [self makeGETRequest:getURL];
}

-(NSDictionary *)getGroupEvolution:(NSString *)groupId
{
    NSString * getURL = [NSString stringWithFormat:@"group/%@/evolution/", groupId];
    return [self makeGETRequest:getURL];
}

-(NSDictionary *)getReceivedMessages
{
    return [self makeGETRequest:@"messages/recv/"];
}

-(NSDictionary *)getSentMessages
{
    return [self makeGETRequest:@"messages/sent/"];
}

-(NSDictionary *)getAllMessages
{
    return [self makeGETRequest:@"messages/all/"];
}

-(NSDictionary *)getAllChallenges
{
    return [self makeGETRequest:@"challenge/list/"];
}

-(NSDictionary *)launchChallengeAgainst:(NSString *)playerId
{
    NSString * getURL = [NSString stringWithFormat:@"challenge/launch/%@/", playerId];
    return  [self makeGETRequest:getURL];
}

-(NSDictionary *)acceptChallengeWithId:(NSString *)challengeId
{
    NSString * getURL = [NSString stringWithFormat:@"challenge/%@/accept/", challengeId];
    return [self makeGETRequest:getURL];
}

-(NSDictionary *)refuseChallengeWithId:(NSString *)challengeId
{
    NSString *getURL = [NSString stringWithFormat:@"challenge/%@/refuse", challengeId];
    return [self makeGETRequest:getURL];
}

-(NSDictionary *)cancelChallengeWithId:(NSString *)challengeId
{
    NSString * getURL = [NSString stringWithFormat:@"challenge/%@/cancel/", challengeId];
    return [self makeGETRequest:getURL];
}

-(NSDictionary *)getChallengeContent:(NSString *)challengeId
{
    NSString * getURL = [NSString stringWithFormat:@"challenge/%@/", challengeId];
    return [self makeGETRequest:getURL];
}

-(NSDictionary *)sendChallengeAnswers: (NSMutableDictionary *)answers ForChallenge:(NSString *)challengeId
{
    NSString * URL = [NSString stringWithFormat:@"challenge/%@/", challengeId];
    NSData * data = [self makePOSTRequest:URL POSTParameters:answers];
    NSDictionary * jsonResponse;
    jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return jsonResponse;
}

@end
