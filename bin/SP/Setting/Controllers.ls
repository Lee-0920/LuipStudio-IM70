setting = {}
setting.plugins = {}
setting.plugins.controllers=
{
    -- TOCDrive Controllers
    {
        name = "TOCDriveControllerPlugin",
        text = "驱动板",
        address = {1,1,1,0},
    },
    -- Liquid Controllers
    {
        name = "LiquidControllerPlugin",
        text = "液路板",
        address = {1,1,16,0},
    },
}


return setting.plugins.controllers
