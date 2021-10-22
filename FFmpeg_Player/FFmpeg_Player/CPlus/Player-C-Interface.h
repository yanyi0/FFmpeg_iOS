//
//  MyObject-C-Interface.h
//  FFmpeg_Player
//
//  Created by 鄢栋云 on 2021/10/13.
//

#ifndef MyObject_C_Interface_h
#define MyObject_C_Interface_h


#endif /* MyObject_C_Interface_h */
int playerDoSomethingWith (void *myObjectInstance, void *parameter);
#pragma mark 解码完成绘制视频帧
void playerDoDraw(void *myObjectInstance,void *data, uint32_t w, uint32_t h);
#pragma mark 播放器状态改变
void stateChanged(void *myObjectInstance);
#pragma mark 音视频解码器初始化完毕
void initFinished(void *myObjectInstance);
#pragma mark 音视频播放音频时间变化
void timeChanged(void *myObjectInstance);
#pragma mark 音视频播放失败
void playFailed(void *myObjectInstance);

