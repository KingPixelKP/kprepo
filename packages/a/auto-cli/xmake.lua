package("auto-cli")
    set_description("The auto-cli package")

    add_urls("https://github.com/KingPixelKP/auto-cli.git")
    add_versions("0.1.0", "2841d2a81d0361ea1b10f3a45baabc9a70dd314f")

    on_install(function (package)
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
        --assert(package:has_cxxincludes("auto-cli/auto-cli.h", {includes = "auto-cli/auto-cli.h"}))
    end)
