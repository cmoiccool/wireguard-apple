#!bin/sh

pwd && ls -al \
            && cd WireGuardKit \
            && pwd && ls -al \
            && cd Sources \
            && pwd && ls -al \
            && cd WireGuardKitGo \
            && pwd && ls -al \
            && make \
            && echo "---------------------------------------------------------------------------" \
            && pwd && ls -al \
            && cd $BUILT_PRODUCTS_DIR \
            && pwd && ls -al \
            && cd WireGuardKit.framework \
            && pwd && ls -al \
            && cd $SRCROOT/WireGuardKit/Sources/WireGuardKitGo/ \
            && pwd && ls -al \
            && cp -r $SRCROOT/WireGuardKit/Sources/WireGuardKitGo/libwg-go.a . \
            && pwd && ls -al