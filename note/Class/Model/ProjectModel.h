//
//  ProjectModel.h
//  note
//
//  Created by apple on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseModel.h"
#import "DetailModel.h"

@interface ProjectModel : BaseModel

@property NSString *name;
@property NSString *state;
@property NSString *firstParty;
@property NSString *money;
@property NSString *dateTime;
@property NSString *startTime;
@property NSString *endTime;
@property NSString *note;
@property RLMArray<DetailModel *><DetailModel> *detailModels;

@end

RLM_ARRAY_TYPE(ProjectModel) // 定义RLMArray<ProjectModel>
