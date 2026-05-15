add_rules("mode.debug", "mode.release", "mode.coverage")
add_rules("plugin.compile_commands.autoupdate", {outputdir = "build"})

--Requires Section
add_requires("gtest")
add_requires("spdlog")

target("${TARGET_NAME}")
    set_kind("static")
    add_headerfiles("include/foo/*.h". {prefixdir = "foo"}) -- Change foo to your ptoject name
    add_files("src/*.cpp|main.cpp")
    add_includedirs("include", {public = true})
    add_includedirs("include/foo", {private = true}) -- Change foo to your ptoject name
    add_includedirs("src", {private = true})

target("main")
    set_kind("binary")
    add_files("src/main.cpp")
    add_deps("${TARGET_NAME}")

task("coverage")
    set_menu({
        usage = "xmake coverage [--clean] [--test] [--html] [--sonarqube]",
        description = "Run tests and generate HTML and SonarQube coverage report",
        options = {
            {nil, "clean",     "k", false, "Remove old coverage data before running tests"},
            {nil, "html",      "k", false, "Generate HTML coverage report"},
            {nil, "sonarqube", "k", false, "Generate SonarQube XML coverage report"},
            {nil, "test",      "k", false, "Run tests before generating coverage report"}
        }
    })
    on_run(function()
        import("core.project.config")
        import("core.base.option")

        config.load()

        ran_something = false

        if option.get("test") then
            if option.get("clean") then
                print("Removing old coverage data...")
                os.exec("find build/ -name \"*.gcda\" -delete")
                os.exec("find build/ -name \"*.gcno\" -delete")
                print("Cleaning build artifacts...")
                os.exec("xmake clean -a")
            end

            -- build with coverage flags
            print("Building project in coverage mode...")
            os.exec("xmake f -m coverage")
            os.exec("xmake build --all")

            -- run tests
            os.exec("xmake test")
        end

        os.mkdir("coverage")
        -- generate report
        if option.get("html") then
            print("Generating HTML coverage report...")
            os.mkdir("coverage/html")os.exec("gcovr -r . --object-directory build/ --html --html-details " ..
                "--exclude '.*\\.grpc\\.pb\\.cc' " ..
                "--exclude '.*\\.pb\\.cc' " ..
                "--exclude 'build/.*' " ..
                "--exclude 'test/.*' " ..
                "-o coverage/html/html_coverage_report.html")
            print("Coverage report: coverage/html/html_coverage_report.html")
            ran_something = true
        end
        if option.get("sonarqube") then
            print("Generating SonarQube coverage report...")
            os.mkdir("coverage/sonarqube")
            os.exec("gcovr -r . --object-directory build/ --sonarqube " ..
                "--exclude '.*\\.grpc\\.pb\\.cc' " ..
                "--exclude '.*\\.pb\\.cc' " ..
                "--exclude 'build/.*' " ..
                "--exclude 'test/.*' " ..
                "-o coverage/sonarqube/sonarqube_coverage_report.xml")
            print("SonarQube coverage report: coverage/sonarqube/sonarqube_coverage_report.xml")
            ran_something = true
        end
        if not ran_something then
            os.exec("xmake coverage --help")
            print("No coverage report generated.")
        end

        os.exec("xmake f -m debug")
    end)
