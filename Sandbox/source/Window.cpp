#include "Window.h"

bool Window::Init(unsigned int width, unsigned int height, std::string engineName, std::string appName)
{
    if (!glfwInit())
    {
        return false;
    }

    glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);

    m_AppName = appName;
    m_Window = glfwCreateWindow(width, height, m_AppName.c_str(), nullptr, nullptr);
    if (!m_Window)
    {
        glfwTerminate();
        return false;
    }
        
    //m_Renderer = std::make_unique<VKRenderer>(m_Window);
    //if (!m_Renderer->Init(engineName, appName))
    //{
    //    glfwTerminate();
    //    return false;
    //}

    return true;
}

void Window::Run()
{
    while (!glfwWindowShouldClose(m_Window))
    {

        glfwPollEvents();
    }
}

void Window::Cleanup()
{
    //m_Renderer->Cleanup();
    glfwDestroyWindow(m_Window);
    glfwTerminate();
}