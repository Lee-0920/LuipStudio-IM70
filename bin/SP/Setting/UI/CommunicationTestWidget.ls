setting.ui.diagnosis.communicationCheck =
{
    name ="communicationCheck",
    text= "通信检测",
    rowCount = 2,
    writePrivilege=  RoleType.Administrator,
    readPrivilege = RoleType.Administrator,
    superRow = 0,
    administratorRow = 2,
    {
        text = "板卡通信",
        name = "BoardCommunication ",
        {
            name ="DCCommunicationCheck",
            text= "驱动板",
            createFlow = function()
				local flow = CommunicationCheckFlow:new({})
				flow.name  = setting.ui.diagnosis.communicationCheck[1][1].name
				FlowList.AddFlow(flow)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="LCCommunicationCheck",
            text= "液路板",
            createFlow = function()
                local flow = CommunicationCheckFlow:new({})
                flow.name  = setting.ui.diagnosis.communicationCheck[1][2].name
                FlowList.AddFlow(flow)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
    },
}
return setting.ui.diagnosis.communicationCheck
