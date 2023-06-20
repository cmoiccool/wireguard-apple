Pod::Spec.new do |s|
    s.name             = 'WireGuardKit'
    s.version          = '1.0.16'
    s.summary          = 'WireGuardKit for iOS and macOS.'
    s.description      = <<-DESC
                         WireGuardKit is a WireGuard wrapper for iOS and macOS.
                         DESC
    s.homepage         = 'https://www.wireguard.com'
    s.license          = { :type => 'MIT', :file => 'COPYING' }
    s.author           = { 'WireGuard LLC' => '
                            WireGuard LLC
                            https://www.wireguard.com
                            ' }
    s.source           = { :git => 'https://github.com/cmoiccool/wireguard-apple.git', :tag => s.version.to_s }
    s.source_files     = 'Sources/WireGuardKit/**/*'
    s.ios.deployment_target = '15.0'
    s.osx.deployment_target = '12.0'
    s.swift_version    = '5.5'

    s.prepare_command  = <<-CMD
./build-wg-lib.sh
    CMD


    s.subspec 'WireGuardKitGoBridgemacOS' do |sbm|
        sbm.platform = :osx, '12.0'
        # Set the SDKROOT to macosx, so that the go build will use the correct SDK
        sbm.user_target_xcconfig = { 'SDKROOT' => 'macosx' }
        sbm.source_files = 'Sources/WireGuardKitGo/**/*'
        # sbi.public_header_files = 'Sources/WireGuardKitGo/*.h'
        # sbi.exclude_files = 'Sources/WireGuardKitGo/{goruntime-boottime-over-monotonic.diff,go.mod,go.sum,api-apple.go,Makefile}'
        # sbi.libraries = 'wg-go'
        sbm.script_phase = {
            :name => 'Compile WireGuardKitGoBridgemacOS Library',
            :script => 'pwd && ls -al \
            && cd WireGuardKit \
            && pwd && ls -al \
            && cd Sources \
            && pwd && ls -al \
            && cd WireGuardKitGo \
            && pwd && ls -al \
            && make $ACTION \
            && echo "---------------------------------------------------------------------------" \
            && pwd && ls -al \
            && cd $BUILT_PRODUCTS_DIR \
            && pwd && ls -al \
            && cd WireGuardKit.framework \
            && pwd && ls -al \
            && cd $SRCROOT/WireGuardKit/Sources/WireGuardKitGo/ \
            && pwd && ls -al \
            && cp -r $BUILT_PRODUCTS_DIR/libwg-go.a . \
            && pwd && ls -al',
            :execution_position => :before_compile
        }
        sbm.vendored_libraries = '$(BUILT_PRODUCTS_DIR)/libwg-go.a'
    end

    s.subspec 'WireGuardKitGoBridgeiOS' do |sbi|
        sbi.platform = :ios, '15.0'
        # Set the SDKROOT to iphoneos, so that the go build will use the correct SDK
        sbi.user_target_xcconfig = { 'SDKROOT' => 'iphoneos' }
        sbi.source_files = 'Sources/WireGuardKitGo/**/*'
        # sbi.public_header_files = 'Sources/WireGuardKitGo/*.h'
        # sbi.exclude_files = 'Sources/WireGuardKitGo/{goruntime-boottime-over-monotonic.diff,go.mod,go.sum,api-apple.go,Makefile}'
        # sbi.libraries = 'wg-go'
        sbi.script_phase = {
            :name => 'Compile WireGuardKitGoBridgeiOS Library',
            :script => 'pwd && ls -al \
            && cd WireGuardKit \
            && pwd && ls -al \
            && cd Sources \
            && pwd && ls -al \
            && cd WireGuardKitGo \
            && pwd && ls -al \
            && make $ACTION \
            && echo "---------------------------------------------------------------------------" \
            && pwd && ls -al \
            && cd $BUILT_PRODUCTS_DIR \
            && pwd && ls -al \
            && cd WireGuardKit.framework \
            && pwd && ls -al \
            && cd $SRCROOT/WireGuardKit/Sources/WireGuardKitGo/ \
            && pwd && ls -al \
            && cp -r $BUILT_PRODUCTS_DIR/libwg-go.a . \
            && pwd && ls -al',
            :execution_position => :before_compile
        }
        sbi.vendored_libraries = '$(BUILT_PRODUCTS_DIR)/libwg-go.a'
    end

    s.subspec 'WireGuardKitGo' do |sg|
        sg.source_files = 'Sources/WireGuardKitGo/**/*'
        sg.public_header_files = 'Sources/WireGuardKitGo/*.h'
        sg.exclude_files = 'Sources/WireGuardKitGo/{goruntime-boottime-over-monotonic.diff,go.mod,go.sum,api-apple.go,Makefile}'
        sg.libraries = 'wg-go'
        # sg.vendored_libraries = '$(BUILT_PRODUCTS_DIR)\libwg-go.a'
    end

    s.subspec 'WireGuardKitC' do |sc|
        sc.source_files = 'Sources/WireGuardKitC/**/*'
        sc.public_header_files = 'Sources/WireGuardKitC/*.h'
    end
end

