LOCAL_PATH:= $(call my-dir)
$(shell cp -r $(LOCAL_PATH)/* $(TARGET_OUT_VENDOR)/firmware/)

# add mitool sign vpu
ifneq ($(BUILD_TARGET_PRODUCT),$(filter qssi missi,$(TARGET_PRODUCT)))
#generate prebuild firmares
SPLIT_TOOL          := vendor/qcom/proprietary/common/scripts/pil-splitter.py
MI_IMAGE_SIGN_TOOL  := vendor/xiaomi/securebootsigner/Qualcomm/common/sign_images.py

include $(CLEAR_VARS)
LOCAL_MODULE        := vpu20_4v.mbn
LOCAL_MODULE_OWNER  := qcom
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := vpu20_4v.mbn
LOCAL_MODULE_PATH   := $(PRODUCT_OUT)/$(TARGET_COPY_OUT_VENDOR)/firmware
include $(BUILD_SYSTEM)/base_rules.mk
$(LOCAL_BUILT_MODULE): VPU_FILE_PATH := $(LOCAL_PATH)/$(LOCAL_SRC_FILES)
$(LOCAL_BUILT_MODULE): VPU_SPLIT_PREFIX := $(LOCAL_PATH)/vpu20_4v
$(LOCAL_BUILT_MODULE): $(VPU_FILE_PATH) $(SPLIT_TOOL) $(MI_IMAGE_SIGN_TOOL)
	echo Calling mi tool to sign and split $(VPU_FILE_PATH)
	VPU_FILE_PATH=$(VPU_FILE_PATH) \
	python $(MI_IMAGE_SIGN_TOOL) -p $(TARGET_PRODUCT) --vpu
	cp -f $(VPU_FILE_PATH) $@
	python $(SPLIT_TOOL) $(VPU_FILE_PATH) $(VPU_SPLIT_PREFIX)
	mkdir -p $(PRODUCT_OUT)/$(TARGET_COPY_OUT_VENDOR)/firmware
	cp -f $(VPU_SPLIT_PREFIX).* $(PRODUCT_OUT)/$(TARGET_COPY_OUT_VENDOR)/firmware
	echo sign and split $(VPU_FILE_PATH) done.

endif
