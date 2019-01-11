# Sets the target folders and the final framework product.
TARGET_NAME="WeexSDK"
FRAMEWORK_NAME="WeexSDK"
SRCROOT="."
# Install dir will be the final output to the framework.
# The following line create it in the root folder of the current project.
INSTALL_DIR=${SRCROOT}/Products/${FRAMEWORK_NAME}.framework
# Working dir will be deleted after the framework creation.
WORKING_DIR=./build
DEVICE_DIR=${WORKING_DIR}/Build/Products/Release-iphoneos/${FRAMEWORK_NAME}.framework
SIMULATOR_DIR=${WORKING_DIR}/Build/Products/Release-iphonesimulator/${FRAMEWORK_NAME}.framework
# -configuration ${CONFIGURATION}
# Cleaning the oldest.
if [ -d "${INSTALL_DIR}" ]
then
rm -rf "${INSTALL_DIR}"
fi
mkdir -p "${INSTALL_DIR}"
# Clean and Building both architectures.
xcodebuild -project "WeexSDK.xcodeproj" -configuration "Release" -scheme "${TARGET_NAME}" -derivedDataPath build -sdk iphoneos clean build
cp -R "${DEVICE_DIR}/" "${INSTALL_DIR}/"
xcodebuild -project "WeexSDK.xcodeproj" -configuration "Release" -scheme "${TARGET_NAME}" -derivedDataPath build -sdk iphonesimulator clean build
# Uses the Lipo Tool to merge both binary files ([arm_v7] [i386] [x86_64] [arm64]) into one Universal final product.
lipo -create "${INSTALL_DIR}/${FRAMEWORK_NAME}" "${SIMULATOR_DIR}/${FRAMEWORK_NAME}" -output "${INSTALL_DIR}/${FRAMEWORK_NAME}"
#rm -r "${WORKING_DIR}"
open "${INSTALL_DIR}"
