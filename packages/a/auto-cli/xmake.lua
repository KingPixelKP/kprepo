package("auto-cli")
    set_description("The auto-cli package")

    add_urls("https://github.com/KingPixelKP/auto-cli.git")
    add_versions("0.1.0", "a8bceb7a687385744a1fa90122cfe624307453c9")

    on_install(function (package)
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
        --assert(package:has_cxxincludes("auto-cli/auto-cli.h", {includes = "auto-cli/auto-cli.h"}))
    end)
