#
# Copyright 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Architecture
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := krait

# Assert
TARGET_OTA_ASSERT_DEVICE := awifi,v500

# Audio
BOARD_USES_ALSA_AUDIO:= true

# Bionic
MALLOC_IMPL := dlmalloc

#BlissPop Config Flags
TARGET_TC_ROM := 5.1-linaro
TARGET_TC_KERNEL := 4.8-linaro
BLISSIFY := true
BLISS_O3 := true
BLISS_STRICT := true
BLISS_GRAPHITE := true
BLISS_KRAIT := true
BLISS_PIPE := true
TARGET_GCC_VERSION_EXP := $(TARGET_TC_ROM)
TARGET_KERNEL_CUSTOM_TOOLCHAIN := $(TARGET_TC_KERNEL)

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := AWIFI
TARGET_BOOTLOADER_NAME := awifi
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/lge/awifi/bluetooth

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_SHOW_PERCENTAGE := true
BOARD_CHARGER_DISABLE_INIT_BLANK := true
BOARD_HEALTHD_CUSTOM_CHARGER_RES := device/lge/awifi/charger/images
BOARD_HEALTHD_CUSTOM_CHARGER := device/lge/awifi/charger/healthd_mode_charger.cpp
COMMON_GLOBAL_CFLAGS += -DBOARD_CHARGING_CMDLINE_NAME='"androidboot.mode"' -DBOARD_CHARGING_CMDLINE_VALUE='"chargerlogo"'
COMMON_GLOBAL_CFLAGS += -DRECOVERY_FONT='"roboto_15x24.h"'

# Flags
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp

# Fonts
EXTENDED_FONT_FOOTPRINT := true

# Graphics
USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_USES_ION := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_DISPLAY_USE_RETIRE_FENCE := true
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so

# Hardware tunables
BOARD_HARDWARE_CLASS := device/lge/awifi/cmhw/

# Kernel
TARGET_KERNEL_SOURCE := kernel/lge/awifi
TARGET_KERNEL_CONFIG := cyanogenmod_awifi_defconfig
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 user_debug=31 msm_rtb.filter=0x3F ehci-hcd.park=3 lpj=67677 androidboot.hardware=awifi vmalloc=400M
BOARD_KERNEL_BASE := 0x80200000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02000000
BOARD_CUSTOM_BOOTIMG_MK := device/lge/awifi/mkbootimg.mk
BOARD_CUSTOM_BOOTIMG := true

# Partitions
TARGET_USERIMAGES_USE_EXT4         := true
TARGET_USERIMAGES_USE_F2FS         := true
BOARD_BOOTIMAGE_PARTITION_SIZE     := 25165824    # 24M
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 25165824    # 24M
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 2248146944  # 2144M
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12071206912 # 11512M
BOARD_CACHEIMAGE_PARTITION_SIZE    := 838860800   # 800M
BOARD_FLASH_BLOCK_SIZE             := 131072      # (BOARD_KERNEL_PAGESIZE * 64)

# Platform
TARGET_BOARD_PLATFORM := msm8960
TARGET_BOARD_PLATFORM_GPU := qcom-adreno320

# Power HAL
TARGET_POWERHAL_VARIANT := qcom

# Recovery
TARGET_RECOVERY_FSTAB := device/lge/awifi/rootdir/fstab.awifi
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

# SELinux policies
include device/qcom/sepolicy/sepolicy.mk

BOARD_SEPOLICY_DIRS += device/lge/awifi/sepolicy

# Time services
BOARD_USES_QC_TIME_SERVICES := true

# Vold
BOARD_VOLD_MAX_PARTITIONS := 40
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
BOARD_VOLD_DISC_HAS_MULTIPLE_MAJORS := true

# Wifi
BOARD_HAS_QCOM_WLAN := true
BOARD_WLAN_DEVICE := qcwcn
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
TARGET_USES_WCNSS_CTRL := true
TARGET_USES_QCOM_WCNSS_QMI := true
WIFI_DRIVER_FW_PATH_STA := "sta"
WIFI_DRIVER_FW_PATH_AP  := "ap"

# inherit from the proprietary version
-include vendor/lge/awifi/BoardConfigVendor.mk


ifeq ($(strip $(BLISS_GRAPHITE)),true)
OPT1 := (graphite)
GRAPHITE_FLAGS := \
  -fgraphite \
  -fgraphite-identity \
  -floop-flatten \
  -floop-parallelize-all \
  -ftree-loop-linear \
  -floop-interchange \
  -floop-strip-mine \
  -floop-block
ifeq ($(strip $(BLISSIFY)),true)
  GRAPHITE_FLAGS += \
    -Wno-error=maybe-uninitialized
endif
endif

# Force disable some modules that are not compatible with graphite flags.
# Add more modules if needed for devices in BoardConfig.mk
# LOCAL_DISABLE_GRAPHITE +=
# Force disable some modules that are not compatible with graphite flags.
# Add more modules if needed for devices in BoardConfig.mk
# LOCAL_DISABLE_GRAPHITE +=
LOCAL_DISABLE_GRAPHITE := \
  libmincrypt \
  mkbootimg \
  mkbootfs \
  libhost \
  ibext2_profile \
  make_ext4fs \
  hprof-conv \
  acp \
  libsqlite \
  libsqlite_jni \
  simg2img_host \
  e2fsck \
  append2simg \
  build_verity_tree \
  sqlite3 \
  e2fsck_host \
  libext2_profile_host \
  libext2_quota_host \
  libext2fs_host\
  libbz\
  make_f2fs\
  imgdiff\
  bsdiff \
  libedify \
  fs_config \
  unpackbootimg \
  mkyaffs2image \
  libext2_com_err_host \
  libext2_blkid_host \
  libext2_e2p_host\
  libcrypto-host \
  libexpat-host \
  libicuuc-host \
  libicui18n-host \
  dmtracedump \
  libsparse_host \
  libz-host \
  libfdlibm \
  libsqlite3_android \
  libssl-host \
  libf2fs_dlutils_host \
  libf2fs_utils_host \
  libf2fs_ioutils_host \
  libf2fs_fmt_host_dyn \
  libext2_uuid_host \
  minigzip \
  libdex \
  dexdump \
  dexlist \
  libext4_utils_host \
  third_party_protobuf_protoc_arm_host_gyp \
  libaapt \
  aapt \
  fastboot  \
  libpng \
  aprotoc \
  fio \
  fsck.f2fs \
  libandroidfw \
  libbacktrace_test \
  liblog \
  libgtest_host \
  libbacktrace_libc++ \
  v8_tools_gyp_v8_nosnapshot_arm_host_gyp \
  third_party_icu_icui18n_arm_host_gyp \
  third_party_icu_icuuc_arm_host_gyp \
  tird_party_protobuf_protobuf_full_do_not_use_arm_host_gyp \
  third_party_protobuf_protobuf_full_do_not_use_arm_host_gyp \
  v8_tools_gyp_mksnapshot_arm_host_gyp \
  third_party_libvpx_libvpx_obj_int_extract_arm_host_gyp \
  libutils \
  libcutils \
  libexpat \
  v8_tools_gyp_v8_base_arm_host_gyp \
  v8_tools_gyp_v8_libbase_arm_host_gyp \
  v8_tools_gyp_v8_libbase_arm_host_gyp_32 \
  aidl \
  libziparchive-host \
  libcrypto_static \
  libunwind-ptrace \
  libgtest_main_host \
  libbacktrace \
  backtrace_test \
  libzopfli \
  zipalign \
  rsg-generator \
  unrar \
  libunz \
  adb \
  libzipfile \
  rsg-generator_support \
  libunwindbacktrace \
  libc_common \
  libz \
  libselinux \
  checkfc \
  checkseapp \
  checkpolicy \
  libsepol \
  libpcre \
  libunwind \
  libFFTEm \
  libicui18n \
  libskia \
  libvpx \
  libmedia_jni \
  libstagefright_mp3dec \
  libart \
  mdnsd \
  libwebrtc_spl \
  third_party_WebKit_Source_core_webcore_svg_gyp \
  libjni_filtershow_filters \
  libavformat \
  libavcodec \
  skia_skia_library_gyp

ifeq (1,$(words $(filter 4.9 4.9-sm,$(TARGET_TC_ROM))))
  LOCAL_DISABLE_GRAPHITE += \
    libFraunhoferAAC
endif

ifeq (true,$(BLISS_O3))
OPT3 := (O3)
endif

ifeq (true,$(BLISS_STRICT))
OPT2 := (strict)
endif

ifeq (true,$(BLISS_KRAIT))
OPT4 := (krait)
endif

GCC_OPTIMIZATION_LEVELS := $(OPT1)$(OPT2)$(OPT3)$(OPT4)
