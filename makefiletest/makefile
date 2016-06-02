#==============================================
#
# Makefile create by ÑÞÑôÂúÌì
# Module : GNaviGPI
#
#==============================================

#----------------------------------------------
# Target File Name And Type Definitions
#----------------------------------------------
EXETYPE 	= a
TARGET		= fGNaviMid
PROJ_DIR 	= .

#----------------------------------------------
# Compile Executable File
#----------------------------------------------
ARMCC 		= /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
ARMCPP 		= /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++
CC 			= /Applications/Xcode5.0.app/Contents/Developer/usr/bin/gcc
CPP 			= /Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/g++-4.2
AR  			= /Applications/Xcode5.0.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/ar

#----------------------------------------------
# Command For Delete File
#----------------------------------------------
DEL_CMD 	= rm -rf

#----------------------------------------------
# Command For Create Directory
#----------------------------------------------
DIR_CMD 	= mkdir -p

#----------------------------------------------
# Generic Flags For Compile
#----------------------------------------------
CC_CMD  	= -arch armv7 -c -std=c99 -W -Wall -O3 \
        		-funroll-loops \
        		-Diphoneos_version_min=2.0 \
        		-Wno-unused-parameter \
        		-Wno-sign-compare \

#----------------------------------------------
# Command Line Option To Specify Output Filename
#----------------------------------------------    		
OUT_CMD 	= -o

#----------------------------------------------
# Extension For Object File
#---------------------------------------------- 
EXT 			= o

## SDK°æ±¾
SDKVER    = 8.3

## iPhone SDKÂ·¾¶
IPHONESDK = /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS$(SDKVER).sdk

CC_CMD += -F"$(IPHONESDK)/System/Library/Frameworks"
CC_CMD += -F"$(IPHONESDK)/System/Library/PrivateFrameworks"

#----------------------------------------------
# Output Directory
#----------------------------------------------
OUTDIR = Lib/iphone/$(SDKVER)
INTDIR = Obj/iphone/$(SDKVER)
LOGDIR = Log/iphone/$(SDKVER)

#----------------------------------------------
# MACRO
#----------------------------------------------
APP_DEF = -DPLATFORM_MAC \
          -D_UNICODE \
          -DMODULE_GPI \
          -DGNAVIGPI_LIB \
					$(DEBUG) \
					$(FILEOP)

#----------------------------------------------
# Include Directory
#----------------------------------------------
APP_INC = -I"$(IPHONESDK)/usr/include" \
					-I"/Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/gcc/arm-apple-darwin9/4.2/include/" \
					-I"/Developer/Platforms/iPhoneOS.platform/Developer/usr/include/" \
					-I"/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator$(SDKVER).sdk/usr/include" \
					-I$(PROJ_DIR)/Include

#----------------------------------------------
# Compile Flags and AR or Link Flags
#----------------------------------------------
CCFLAGS = $(CC_CMD) $(APP_DEF) $(APP_INC)
ARFLAGS = -r $(OUTDIR)/$(TARGET).$(EXETYPE)

#----------------------------------------------
# DO NOT EDIT BELOW THIS LINE
#----------------------------------------------


ALL: DIR CLEAN Simulator_TARGET Device_TARGET Simulator_TARGET_DEBUG Device_TARGET_DEBUG CLEANIT

DIR:
	$(DIR_CMD) "$(OUTDIR)/simulator/debug"
	$(DIR_CMD) "$(INTDIR)/simulator/debug"
	$(DIR_CMD) "$(OUTDIR)/device/debug"
	$(DIR_CMD) "$(INTDIR)/device/debug"
	$(DIR_CMD) "$(OUTDIR)/simulator/release"
	$(DIR_CMD) "$(INTDIR)/simulator/release"
	$(DIR_CMD) "$(OUTDIR)/device/release"
	$(DIR_CMD) "$(INTDIR)/device/release"
	$(DIR_CMD) "$(LOGDIR)"

CLEAN:
	@echo -------------------------------------------
	@echo CLEAN
	$(DEL_CMD) $(INTDIR)/simulator/debug/MYCLASS/*.$(EXT)
	$(DEL_CMD) $(INTDIR)/simulator/release/MYCLASS/*.$(EXT)
	$(DEL_CMD) $(INTDIR)/device/debug/MYCLASS/*.$(EXT)
	$(DEL_CMD) $(INTDIR)/device/release/MYCLASS/*.$(EXT)
	$(DEL_CMD) $(LOGDIR)/*.log
	$(DEL_CMD) $(OUTDIR)/simulator/debug/$(TARGET).$(EXETYPE)
	$(DEL_CMD) $(OUTDIR)/simulator/release/$(TARGET).$(EXETYPE)
	$(DEL_CMD) $(OUTDIR)/device/debug/$(TARGET).$(EXETYPE)
	$(DEL_CMD) $(OUTDIR)/device/release/$(TARGET).$(EXETYPE)
	@echo -------------------------------------------

CLEANIT:
	@echo -------------------------------------------
	@echo CLEAN
	$(DEL_CMD) $(OUTDIR)/*.$(EXETYPE)
	@echo -------------------------------------------

#----------------------------------------------
# SIMULATOR TARGET
#----------------------------------------------
Simulator_TARGET : Simulator_MyClass
	@echo -------------------------------------------
	@echo $(TARGET)
	@echo -------------------------------------------
	$(AR) -r $(OUTDIR)/simulator/release/$(TARGET).$(EXETYPE) $(INTDIR)/simulator/release/MYCLASS/*.o

Simulator_MyClass: 
	cd -P MYCLASS
	$(MAKE) -$(MAKEFLAGS) -f MYCLASS/makefile-iphone "DEBUG=-DNDEBUG" "FILEOP=-DIPHONE_FILE" REBUILD INTDIR=$(INTDIR)/simulator/release/MYCLASS 2> $(LOGDIR)/NaviEngine_release.log
	cd ..

	
Simulator_TARGET_DEBUG : MyClass_DEBUG 
	@echo -------------------------------------------
	@echo $(TARGET)
	@echo -------------------------------------------
	$(AR) -r $(OUTDIR)/simulator/debug/$(TARGET).$(EXETYPE) $(INTDIR)/simulator/debug/MYCLASS/*.o 

MyClass_DEBUG: 
	cd -P MYCLASS
	$(MAKE) -$(MAKEFLAGS) -f myclass/makefile-iphone "DEBUG=-D_DEBUG" "FILEOP=-DIPHONE_FILE" REBUILD INTDIR=$(INTDIR)/simulator/debug/MYCLASS 2> $(LOGDIR)/NaviEngine_debug.log
	cd ..
	
#----------------------------------------------
# DEVICE TARGET
#----------------------------------------------
Device_TARGET : D_MyClass
	@echo -------------------------------------------
	@echo $(TARGET)
	@echo -------------------------------------------
	$(AR) -r $(OUTDIR)/device/release/$(TARGET).$(EXETYPE) $(INTDIR)/device/release/MYCLASS/*.o 

D_MyClass: 
	cd -P MYCLASS
	$(MAKE) -$(MAKEFLAGS) -f myclass/makefile-iphone "DEBUG=-DNDEBUG" "FILEOP=-DIPHONE_FILE" REBUILD CC=$(ARMCC) CPP=$(ARMCPP) INTDIR=$(INTDIR)/device/release/MYCLASS 2> $(LOGDIR)/NaviEngine_release.log
	cd ..

Device_TARGET_DEBUG : D_MyClass_DEBUG 
	@echo -------------------------------------------
	@echo $(TARGET)
	@echo -------------------------------------------
	$(AR) -r $(OUTDIR)/device/debug/$(TARGET).$(EXETYPE) $(INTDIR)/device/debug/MYCLASS/*.o

D_MyClass_DEBUG: 
	cd -P MYCLASS
	$(MAKE) -$(MAKEFLAGS) -f myclass/makefile-iphone "DEBUG=-D_DEBUG" "FILEOP=-DIPHONE_FILE" REBUILD CC=$(ARMCC) CPP=$(ARMCPP) INTDIR=$(INTDIR)/device/debug/MYCLASS 2> $(LOGDIR)/NaviEngine_debug.log
	cd ..

######## compile

.SUFFIXES: .cpp .cxx .cc .C .c .m

.c.o:
	@echo -------------------------------------------
	@echo $(<F)
	@echo -------------------------------------------
	$(CC) $(CCFLAGS) -o $@ $<
	
.cpp.o:
	@echo -------------------------------------------
	@echo $(<F)
	@echo -------------------------------------------
	$(CC) $(CCFLAGS) -o $@ $<
	
######## End Of Makefile