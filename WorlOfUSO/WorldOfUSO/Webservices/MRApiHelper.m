//
//  MRApiHelper.m
//  WorldOfUSO
//
//  Created by Andrei Vasilescu on 9/26/14.
//  Copyright (c) 2014 mReady. All rights reserved.
//

#import "MRApiHelper.h"

@implementation MRApiHelper

- (void)getUserInfoWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:@"info/" parameters:nil success:success failure:failure];
}

- (void)getAvailableSpellsInfoWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:@"bazaar/" parameters:nil success:success failure:failure];
}

- (void)getInventorySpellsInfoWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:@"bazaar/inventory/" parameters:nil success:success failure:failure];
}

- (void)buySpell:(NSString *)spellID withSuccess:(void (^)(BOOL response))success andFailure:(void (^)(NSError *err))failure {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:spellID forKey:@"spell"];
    
    [super doPOSTRequest:@"/bazaar/buy" parameters:params success:^(id responseObject) {
        success([[responseObject objectForKey:@"success"] boolValue]);
    } failure:failure ];
}

- (void)sendMessage:(NSString *)message toReceiver:(NSString *)receiver withSubject:(NSString *)subject
        withSuccess:(void (^)(BOOL success))success andFailure:(void (^)(NSError *err))failure {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:receiver forKey:@"receiver"];
    [params setObject:message forKey:@"text"];
    if (subject != nil)
        [params setObject:subject forKey:@"subject"];
    
    [super doPOSTRequest:@"/messages/send/" parameters:params success:^(id responseObject) {
        success([[responseObject objectForKey:@"success"] boolValue]);
    } failure:failure];
}

- (void)sendMessage:(NSString *)message toReceiver:(NSString *)receiver withSubject:(NSString *)subject asReplyTo:(NSString *)reply_to
        withSuccess:(void (^)(BOOL success))success andFailure:(void (^)(NSError *err))failure {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:receiver forKey:@"receiver"];
    [params setObject:message forKey:@"text"];
    [params setObject:reply_to forKey:@"reply_to"];
    if (subject != nil)
        [params setObject:subject forKey:@"subject"];
    
    [super doPOSTRequest:@"/messages/send/" parameters:params success:^(id responseObject) {
        success([[responseObject objectForKey:@"success"] boolValue]);
    } failure:failure];
}

- (void)getTopRacesWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:@"top/race/" parameters:nil success:success failure:failure];
}

- (void)getUserInfo:(NSString *)userID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"player/%@/info/", userID] parameters:nil success:success failure:failure];
}

- (void)getTopGroupsInRace:(NSString *)raceID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"top/race/%@/group/", raceID] parameters:nil success:success failure:failure];
}

- (void)getTopUsersInRace:(NSString *)raceID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"top/race/%@/player/", raceID] parameters:nil success:success failure:failure];
}

- (void)getTopGroupsWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:@"top/group/" parameters:nil success:success failure:failure];
}

- (void)getTopPlayersInGroup:(NSString *)groupID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"top/group/%@/player", groupID] parameters:nil success:success failure:failure];
}

- (void)getTopPlayersWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:@"top/player/" parameters:nil success:success failure:failure];
}

- (void)getAllRacesWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:@"race/" parameters:nil success:success failure:failure];
}

- (void)getAllGroupsWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:@"group/" parameters:nil success:success failure:failure];
}

- (void)getPlayersInRace:(NSString *)raceID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"race/%@/members/", raceID] parameters:nil success:success failure:failure];
}

- (void)getGroupsInRace:(NSString *)raceID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"race/%@/groups/", raceID] parameters:nil success:success failure:failure];
}

- (void)getGroupInfo:(NSString *)groupID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"group/%@/", groupID] parameters:nil success:success failure:failure];
}

- (void)getGroupMembers:(NSString *)groupID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"group/%@/members/", groupID] parameters:nil success:success failure:failure];
}

- (void)getGroupActivity:(NSString *)groupID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"group/%@/activity/", groupID] parameters:nil success:success failure:failure];
}

- (void)getGroupEvolution:(NSString *)groupID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"group/%@/evolution", groupID] parameters:nil success:success failure:failure];
}

- (void)getReceivedMessagesWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:@"messages/recv/" parameters:nil success:success failure:failure];
}

- (void)getSentMessagesWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:@"messages/sent/" parameters:nil success:success failure:failure];
}

- (void)getAllMessagesWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:@"messages/all" parameters:nil success:success failure:failure];
}

- (void)getAllChallengesWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:@"challenge/list" parameters:nil success:success failure:failure];
}

- (void)launchChallengeAgainst:(NSString *)playerID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"challenge/launch/%@/", playerID] parameters:nil success:success failure:failure];
}

- (void)acceptChallengeWithID:(NSString *)challengeID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"challenge/%@/accept/", challengeID] parameters:nil success:success failure:failure];
}

- (void)refuseChallengeWithID:(NSString *)challengeID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"challenge/%@/refuse/", challengeID] parameters:nil success:success failure:failure];
}

- (void)cancelChallengeWithID:(NSString *)challengeID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"challenge/%@/cancel/", challengeID] parameters:nil success:success failure:failure];
}

- (void)getChallengeContent:(NSString *)challengeID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure
{
    [self doGETRequest:[NSString stringWithFormat:@"challenge/%@/", challengeID] parameters:nil success:success failure:failure];
}

- (void)sendChallengeAnswers:(NSMutableDictionary *)answers forChallenge:(NSString *)challengeID
        withSuccess:(void (^)(id success))success andFailure:(void (^)(NSError *err))failure {
    
    [super doPOSTRequest:[NSString stringWithFormat:@"challenge/%@/", challengeID] parameters:answers success:success failure:failure];
}

- (void)markReadMessage:(NSString *)msgID
                 withSuccess:(void (^)(id success))success andFailure:(void (^)(NSError *err))failure {
    
    [super doPOSTRequest:[NSString stringWithFormat:@"/messages/setread/%@/", msgID] parameters:nil success:success failure:failure];
}
@end
