//
//  ApiHelper.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 11/04/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define key @"key"
#define secret @"secret"
#define wousoHost @"wouso.cs.pub.ro/next/api/"

@interface ApiHelper : NSObject

@property (strong, nonatomic) NSString * token;
@property (strong, nonatomic) NSString * tokenSecret;

-(UIImage *)getImageForURL:(NSString *)imgUrl;
-(NSDictionary *)getUserInfo:(NSString *)userId;
-(NSDictionary *)getUserInfo;
-(NSDictionary *)getAvailableSpells;
-(NSDictionary *)getInventorySpells;
-(BOOL)buySpell:(NSString *)spellId;
-(NSArray *)getTopRaces;
-(NSDictionary *)getTopGroupsInRace:(NSString *)raceId;
-(NSDictionary *)getTopUsersInRace:(NSString *)raceId;
-(NSArray *)getTopGroups;
-(NSArray *)getTopPlayers;
-(NSDictionary *)getAllRaces;
-(NSDictionary *)getAllGroups;
-(NSDictionary *)getPlayersInRace:(NSString *)raceId;
-(NSDictionary *)getGroupsInRace:(NSString *)raceId;
-(NSDictionary *)getGroupInfo:(NSString *)groupId;
-(NSDictionary *)getGroupMembers:(NSString *)groupId;
-(NSDictionary *)getGroupActivity:(NSString *)groupId;
-(NSDictionary *)getGroupEvolution:(NSString *)groupId;
-(NSDictionary *)getReceivedMessages;
-(NSDictionary *)getSentMessages;
-(NSDictionary *)getAllMessages;
-(BOOL)sendMessage:(NSString*)message toReceiver:(NSString*)receiver withSubject:(NSString*)subject;
-(NSDictionary *)launchChallengeAgainst:(NSString *)playerId;
-(NSDictionary *)acceptChallengeWithId:(NSString *)challengeId;
-(NSDictionary *)refuseChallengeWithId:(NSString *)challengeId;
-(NSDictionary *)cancelChallengeWithId:(NSString *)challengeId;
-(NSDictionary *)getChallengeContent:(NSString*)challengeId;
-(NSDictionary *)sendChallengeAnswers:(NSMutableDictionary*)answers ForChallenge:(NSString *)challengeId;

@end
