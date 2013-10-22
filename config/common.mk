# brand
PRODUCT_BRAND ?= Carbon

#SuperUser
SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.cyanogenmod.superuser

# overrides
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    persist.sys.root_access=3

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml


# selinux dialog
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=0

# Camera shutter sound property
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.camera-sound=1

# packages
PRODUCT_PACKAGES += \
    Apollo \
    BlueBalls \
    BluetoothExt \
    Camera \
    CarbonFibers \
    Development \
    DSPManager \
    CMFileManager \
    Galaxy4 \
    libcyanogen-dsp \
    LiveWallpapers \
    LiveWallpapersPicker \
    LockClock \
    NoiseField \
    PhaseBeam \
    PhotoTable \
    SunBeam \
    Superuser \
    su \
    Torch \
    Trebuchet \
    VoicePlus \
    Wallpapers \
    audio_effects.conf


# prebuilts
PRODUCT_PACKAGES += \
    BaiduInputMi

# tools
PRODUCT_PACKAGES += \
    CellBroadcastReceiver

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

PRODUCT_PACKAGES += \
    e2fsck \
    mke2fs \
    tune2fs \
    nano \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# languages
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# themes
include vendor/carbon/config/theme_chooser.mk

#korean
$(call inherit-product-if-exists, external/naver-fonts/fonts.mk)

# overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/carbon/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/carbon/overlay/common

# bin
PRODUCT_COPY_FILES += \
    vendor/carbon/prebuilt/common/bin/sysinit:system/bin/sysinit

# etc
PRODUCT_COPY_FILES += \
    vendor/carbon/prebuilt/common/etc/init.carbon.rc:root/init.carbon.rc

# prebuilt
PRODUCT_COPY_FILES += \
    vendor/carbon/prebuilt/common/xbin/sysro:system/xbin/sysro \
    vendor/carbon/prebuilt/common/xbin/sysrw:system/xbin/sysrw \
    vendor/carbon/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/carbon/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd
    
# phoneloc
PRODUCT_COPY_FILES += \
    vendor/carbon/prebuilt/common/lib/libphoneloc-jni.so:system/lib/libphoneloc-jni.so \
    vendor/carbon/prebuilt/common/usr/share/phoneloc.dat:system/usr/share/phoneloc.dat 

#backup tool
CARBON_BUILD = true
PRODUCT_COPY_FILES += \
    vendor/carbon/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/carbon/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/carbon/prebuilt/common/bin/50-carbon.sh:system/addon.d/50-carbon.sh \
    vendor/carbon/prebuilt/common/bin/blacklist:system/addon.d/blacklist \
    vendor/carbon/prebuilt/common/bin/99-backup.sh:system/addon.d/99-backup.sh \
    vendor/carbon/prebuilt/common/etc/backup.conf:system/etc/backup.conf     
# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/carbon/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# sip/voip
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# nfc
PRODUCT_COPY_FILES += \
    vendor/carbon/config/permissions/com.carbon.android.xml:system/etc/permissions/com.carbon.android.xml \
    vendor/carbon/config/permissions/com.carbon.nfc.enhanced.xml:system/etc/permissions/com.carbon.nfc.enhanced.xml

# version
RELEASE = false
CARBON_VERSION_MAJOR = 2
CARBON_VERSION_MINOR = 0

#Set CARBON_BUILDTYPE and goo.im properties
ifdef CARBON_NIGHTLY
    CARBON_BUILDTYPE := NIGHTLY
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.goo.rom=carbonjb3exp \
        ro.goo.developerid=carbon \
        ro.goo.version=$(shell date +%Y%m%d)
endif
ifdef CARBON_EXPERIMENTAL
    CARBON_BUILDTYPE := EXPERIMENTAL
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.goo.rom=carbonjb3exp \
        ro.goo.developerid=carbon \
        ro.goo.version=$(shell date +%Y%m%d)
endif
ifdef CARBON_RELEASE
    CARBON_BUILDTYPE := RELEASE
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.goo.rom=carbonjb2 \
        ro.goo.developerid=carbon \
        ro.goo.version=$(shell date +%Y%m%d)
endif
#Set Unofficial if no buildtype set (Buildtype should ONLY be set by Carbon Devs!)
ifdef CARBON_BUILDTYPE
    CARBON_BUILDTYPE := UNOFFICIAL
    CARBON_VERSION_MAJOR :=1.026
    PRODUCT_VERSION_MAINTENANCE = $(shell date +"%y"|rev|cut -c-1|rev).$(shell date +"%m"|sed -e 's/^0//' -e 's/ 0/ /g').$(shell date +"%d"|sed -e 's/^0//' -e 's/ 0/ /g')
else
    CARBON_BUILDTYPE := UNOFFICIAL
    CARBON_VERSION_MAJOR :=1.026
    PRODUCT_VERSION_MAINTENANCE = $(shell date +"%y"|rev|cut -c-1|rev).$(shell date +"%m"|sed -e 's/^0//' -e 's/ 0/ /g').$(shell date +"%d"|sed -e 's/^0//' -e 's/ 0/ /g')
endif

#Set Carbon version
ifdef CARBON_RELEASE
    CARBON_VERSION := "MICARBON-JB-v$(CARBON_VERSION_MAJOR)
else
    CARBON_VERSION := MICARBON-JB-v$(CARBON_VERSION_MAJOR)-$(PRODUCT_VERSION_MAINTENANCE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.carbon.version=$(CARBON_VERSION)

# ROM Statistics and ROM Identification
PRODUCT_PROPERTY_OVERRIDES += \
ro.romstats.askfirst=1 \
ro.romstats.ga=UA-43747246-1 \
ro.romstats.name=CarbonRom- \
ro.romstats.url=http://carbon-stats.mattman.org \
ro.romstats.version=$(CARBON_VERSION)

-include vendor/carbon/sepolicy/sepolicy.mk
