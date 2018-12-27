#ifndef __HARDWARE_PROFILE_H
#define __HARDWARE_PROFILE_H

#define CLOCK_FREQ			(11059200ul)      // Hz

#define GetSystemClock()		CLOCK_FREQ
#define GetInstructionClock()	(GetSystemClock()/4)
#define GetPeripheralClock()	GetInstructionClock()
#define Delay10us(us)			Delay10TCYx(((GetInstructionClock()/1000000)*us))
#define DelayMs(ms)												\
do																\
{																\
	unsigned int _iTemp = (ms); 								\
	while(_iTemp--)												\
		Delay1KTCYx((GetInstructionClock()+999999)/1000000);	\
} while(0)

#endif
