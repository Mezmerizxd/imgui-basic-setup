#pragma once

#include "imgui/imgui.h"
#include "imgui/imgui_impl_glfw.h"
#include "imgui/imgui_impl_opengl3.h"

class BasicImGui {
private:
	bool show_demo_window = false;
public:
	void Init(GLFWwindow* window, const char* glsl_version);
	void NewFrame();
	virtual void Update();
	void Render();
	void Shutdown();
};