//
//  MRApiHelper.h
//  WorldOfUSO
//
//  Created by Andrei Vasilescu on 9/26/14.
//  Copyright (c) 2014 mReady. All rights reserved.
//

#import "MRApiBase.h"

@interface MRApiHelper : MRApiBase

- (void)getUserInfoWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getAvailableSpellsInfoWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getInventorySpellsInfoWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)buySpell:(NSString *)spellID withSuccess:(void (^)(BOOL response))success andFailure:(void (^)(NSError *err))failure;
- (void)sendMessage:(NSString *)message toReceiver:(NSString *)receiver withSubject:(NSString *)subject
        withSuccess:(void (^)(BOOL success))success andFailure:(void (^)(NSError *err))failure;
- (void)sendMessage:(NSString *)message toReceiver:(NSString *)receiver withSubject:(NSString *)subject asReplyTo:(NSString *)reply_to
        withSuccess:(void (^)(BOOL success))success andFailure:(void (^)(NSError *err))failure;
- (void)getTopRacesWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getUserInfo:(NSString *)userID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getTopGroupsInRace:(NSString *)raceID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getTopUsersInRace:(NSString *)raceID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getTopGroupsWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getTopPlayersInGroup:(NSString *)groupID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getTopPlayersWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getAllRacesWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getAllGroupsWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getPlayersInRace:(NSString *)raceID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getGroupsInRace:(NSString *)raceID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getGroupInfo:(NSString *)groupID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getGroupMembers:(NSString *)groupID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getGroupActivity:(NSString *)groupID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getGroupEvolution:(NSString *)groupID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getReceivedMessagesWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getSentMessagesWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getAllMessagesWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getAllChallengesWithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)launchChallengeAgainst:(NSString *)playerID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)acceptChallengeWithID:(NSString *)challengeID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)refuseChallengeWithID:(NSString *)challengeID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)cancelChallengeWithID:(NSString *)challengeID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)getChallengeContent:(NSString *)challengeID WithSuccess:(void (^)(id response))success andFailure:(void (^)(NSError *err))failure;
- (void)sendChallengeAnswers:(NSMutableDictionary *)answers forChallenge:(NSString *)challengeID
                 withSuccess:(void (^)(id success))success andFailure:(void (^)(NSError *err))failure;
- (void)markReadMessage:(NSString *)msgID
            withSuccess:(void (^)(id success))success andFailure:(void (^)(NSError *err))failure;

@end
