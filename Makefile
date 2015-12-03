TWEAK_NAME = InCameraFPS

InCameraFPS_FILES = $(wildcard ./*.*m)
InCameraFPS_FRAMEWORKS = CoreGraphics
InCameraFPS_LDFLAGS += -Wl,-segalign,4000

export TARGET = iphone:clang
export ARCHS = armv7 armv7s arm64
export SDKVERSION = 9.0
export ADDITIONAL_OBJCFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Camera; killall -9 Preferences"
