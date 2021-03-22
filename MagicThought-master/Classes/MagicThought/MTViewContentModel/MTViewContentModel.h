//
//  MTViewContentModel.h
//  QXProject
//
//  Created by monda on 2019/12/5.
//  Copyright © 2019 monda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTBaseViewContentModel.h"

@interface MTViewContentModel : MTBaseViewContentStateModel

/**textLabel*/
@property (nonatomic,strong) MTBaseViewContentModel* mtTitle;

/**detailTextLabel*/
@property (nonatomic,strong) MTBaseViewContentModel* mtContent;

/**第二个detailTextLabel*/
@property (nonatomic,strong) MTBaseViewContentModel* mtContent2;

/**第三个detailTextLabel*/
@property (nonatomic,strong) MTBaseViewContentModel* mtContent3;

/**第四个detailTextLabel*/
@property (nonatomic,strong) MTBaseViewContentModel* mtContent4;

/**第五个detailTextLabel*/
@property (nonatomic,strong) MTBaseViewContentModel* mtContent5;

/**第六个detailTextLabel*/
@property (nonatomic,strong) MTBaseViewContentModel* mtContent6;

/**第七个detailTextLabel*/
@property (nonatomic,strong) MTBaseViewContentModel* mtContent7;

/**第八个detailTextLabel*/
@property (nonatomic,strong) MTBaseViewContentModel* mtContent8;

/**imageView*/
@property (nonatomic,strong) MTBaseViewContentModel* mtImg;

/**imageView2*/
@property (nonatomic,strong) MTBaseViewContentModel* mtImg2;

/**imageView3*/
@property (nonatomic,strong) MTBaseViewContentModel* mtImg3;

/**imageView4*/
@property (nonatomic,strong) MTBaseViewContentModel* mtImg4;

/**imageView5*/
@property (nonatomic,strong) MTBaseViewContentModel* mtImg5;

/**imageView6*/
@property (nonatomic,strong) MTBaseViewContentModel* mtImg6;

/**imageView7*/
@property (nonatomic,strong) MTBaseViewContentModel* mtImg7;

/**imageView8*/
@property (nonatomic,strong) MTBaseViewContentModel* mtImg8;

/**imageView9*/
@property (nonatomic,strong) MTBaseViewContentModel* mtImg9;

/**btn*/
@property (nonatomic,strong) MTBaseViewContentModel* mtBtnTitle;

/**btn2 */
@property (nonatomic,strong) MTBaseViewContentModel* mtBtnTitle2;

/**btn3 */
@property (nonatomic,strong) MTBaseViewContentModel* mtBtnTitle3;

/**btn4*/
@property (nonatomic,strong) MTBaseViewContentModel* mtBtnTitle4;

/**btn5 */
@property (nonatomic,strong) MTBaseViewContentModel* mtBtnTitle5;

/**btn6 */
@property (nonatomic,strong) MTBaseViewContentModel* mtBtnTitle6;

/**btn7 */
@property (nonatomic,strong) MTBaseViewContentModel* mtBtnTitle7;

/**btn8 */
@property (nonatomic,strong) MTBaseViewContentModel* mtBtnTitle8;

/**btn9 */
@property (nonatomic,strong) MTBaseViewContentModel* mtBtnTitle9;

/**textField */
@property (nonatomic,strong) MTBaseViewContentModel* mtTextField;

/**textView */
@property (nonatomic,strong) MTBaseViewContentModel* mtTextView;

/**扩展内容*/
@property (nonatomic,strong) NSObject* mtExternContent;

-(CGFloat)setUpEstimateHeight;

@end







