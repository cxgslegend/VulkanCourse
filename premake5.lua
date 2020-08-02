workspace "Vulkan"
	architecture "x86_64"
	startproject "Sandbox"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

	flags
	{
		"MultiProcessorCompile"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- A dictionary of paths
Path = {}
Path["include"] = "/usr/local/include"
Path["lib"] = "/usr/local/lib"

project "VulkanEngine"
	location "VulkanEngine"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "src/vkpch.h"
	pchsource "src/vkpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	defines
	{
		"GLFW_INCLUDE_NONE"
	}

	sysincludedirs
	{
		"%{Path.include}"
	}

	libdirs
	{
		"%{Path.lib}"
	}

	-- When linking to system libraries, don't include prefix or filetype
	-- https://github.com/premake/premake-core/issues/1322
	links
	{
		"glfw.3.3",
		"vulkan.1.2.141",
		"vulkan.1"
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{
		}

	filter "system:macosx"
		systemversion "latest"

		defines
		{
			GLFW_INCLUDE_VULKAN,
			GLM_FORCE_RADIANS,
			GLM_FORCE_DEPTH_ZERO_TO_ONE
		}

	filter "configurations:Debug"
		defines "VK_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "VK_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "VK_DIST"
		runtime "Release"
		optimize "on"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	sysincludedirs
	{
		"VulkanEngine/src",
		"%{Path.include}"
	}

	libdirs
	{
		"%{Path.lib}"
	}

	-- When linking to system libraries, don't include prefix or filetype
	-- https://github.com/premake/premake-core/issues/1322
	links
	{
		"VulkanEngine",
		"glfw.3.3",
		"vulkan.1.2.141",
		"vulkan.1"
	}

	filter "system:windows"
		systemversion "latest"

	filter "system:macosx"
		systemversion "latest"

	filter "configurations:Debug"
		defines "VK_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "VK_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "VK_DIST"
		runtime "Release"
		optimize "on"

