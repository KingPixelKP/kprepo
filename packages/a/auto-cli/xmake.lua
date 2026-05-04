package("auto-cli")
    set_description("The auto-cli package")

    add_urls("https://github.com/KingPixelKP/auto-cli.git")
    add_versions("0.1.0", "6c1d1bb1d95fde3a9b73d2aa41973aadd4728fb3")

    on_install(function (package)
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
        --assert(package:has_cxxincludes("auto-cli/auto-cli.h", {includes = "auto-cli/auto-cli.h"}))
    end)
