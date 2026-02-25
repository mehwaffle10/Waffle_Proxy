
const string PROXIED_IP = "127.0.0.1:50305";
const string RECONNECT_IP = "127.0.0.1:50305";
const string RECONNECT_COMMAND = "reconnect_command";

void onInit(CRules@ this)
{
	this.addCommandID(RECONNECT_COMMAND);
}

void onCommand(CRules@ this, u8 cmd, CBitStream @params)
{
	if (cmd == this.getCommandID(RECONNECT_COMMAND))
	{
		CNet@ net = getNet();
		print("ReconnectViaProxy command received. net.joined_ip: " + net.joined_ip + " net.sv_current_ip: " + net.sv_current_ip + " net.joined_servername: " + net.joined_servername + " net.lastErrorMsg: " + net.lastErrorMsg);
		if (net.joined_ip != "unknown" && net.joined_ip != PROXIED_IP)
		{
			print("Reconnecting from " + net.joined_ip + " to " + RECONNECT_IP);
			net.SafeConnect(RECONNECT_IP);
		}
	}
}

void onNewPlayerJoin(CRules@ this, CPlayer@ player)
{
	if (isServer())
	{
		CBitStream params;
		this.SendCommand(this.getCommandID(RECONNECT_COMMAND), params, player);
	}
}
