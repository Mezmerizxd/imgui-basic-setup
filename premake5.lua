workspace "imgui-basic-setup"
  architecture "x64"
  startproject "imgui-basic-setup"

  configurations
  {
    "Debug",
    "Release",
    "Dist"
  }

  outputdir = "%{cfg.buildcfg}"

  IncludeDir = {}
  IncludeDir["GLFW"] = "vendor/glfw/include"
  
  CppVersion = "C++14"
  MsvcToolset = "v143"
  WindowsSdkVersion = "10.0"
  
  function DeclareMSVCOptions()
    filter "system:windows"
    staticruntime "Off"
    systemversion (WindowsSdkVersion)
    toolset (MsvcToolset)
    cppdialect (CppVersion)
    characterset ("MBCS") -- Could cause build issue

    defines
    {
      "_CRT_SECURE_NO_WARNINGS",
      "NOMINMAX",
      "WIN32_LEAN_AND_MEAN",
      "_WIN32_WINNT=0x601" -- Support Windows 7
    }
    
    disablewarnings
    {
      "4100", -- C4100: unreferenced formal parameter
      "4201", -- C4201: nameless struct/union
      "4307"  -- C4307: integral constant overflow
    }
  end
   
  project "imgui-basic-setup"
    location "imgui-basic-setup"
    kind "ConsoleApp"
    language "C++"

    targetdir ("bin/" .. outputdir)
    objdir ("bin/int/" .. outputdir .. "/%{prj.name}")

    PrecompiledHeaderInclude = "common.hpp"
    PrecompiledHeaderSource = "%{prj.name}/src/common.cpp"
 
    files
    {
      "%{prj.name}/src/**.hpp",
      "%{prj.name}/src/**.cpp",
      "%{prj.name}/src/**.asm"
    }

    includedirs
    {
      "%{IncludeDir.GLFW}",
      "%{prj.name}/src"
    }

    libdirs
    {
      "bin/lib",
      "vendor/glfw/lib-vc2010-64"
    }

    links
    {
      "opengl32.lib",
      "glfw3.lib"
    }

    -- pchheader "%{PrecompiledHeaderInclude}"
    -- pchsource "%{PrecompiledHeaderSource}"

    -- forceincludes
    -- {
    --   "%{PrecompiledHeaderInclude}"
    -- }
    
    DeclareMSVCOptions()

    configuration "Debug"
      symbols "On"
      defines { "_DEBUG" }

    configuration "Release"
      optimize "On"
      defines { "NDEBUG" }
