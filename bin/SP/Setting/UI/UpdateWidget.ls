setting.ui.update =
{
    rowCount = 2,
    superRow = 0,
    administratorRow = 2,
    writePrivilege=  RoleType.Administrator,
    readPrivilege = RoleType.Administrator,
    {
        name = "TOCDriveControllerPlugin",
        text = "驱动板",
        writePrivilege = RoleType.Administrator,
        readPrivilege = RoleType.Administrator,
        fileName = "IM70TOCDriveController.hex",
    },
    {
        name = "LiquidControllerPlugin",
        text = "液路板",
        writePrivilege = RoleType.Administrator,
        readPrivilege = RoleType.Administrator,
        fileName = "IM70LiquidDriveController.hex",
    },
}
return setting.ui.update
