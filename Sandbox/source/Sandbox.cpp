#include "Window.h"

int main()
{
    Window win{};
    win.Init(1920, 1080);
    win.Run();
    win.Cleanup();
    return 0;
}
