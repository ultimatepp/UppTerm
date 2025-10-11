#include <Terminal/Terminal.h>
#include <PtyProcess/PtyProcess.h>

using namespace Upp;

#ifdef PLATFORM_POSIX
const char *tshell = "SHELL";
#elif PLATFORM_WIN32
const char *tshell = "ComSpec"; // Alternatively you can use powershell...
#endif

#define IMAGECLASS UppTermImg
#define IMAGEFILE <UppTerm/UppTerm.iml>
#include <Draw/iml.h>

class UppTerm final : TopWindow {
public:
	UppTerm()
	{
		Title(m_title_prefix);
		Icon(UppTermImg::Icon());
		SetRect(m_terminal.GetStdSize());
		Sizeable().Zoomable().Add(m_terminal.SizePos());
		
		m_terminal.WindowReports();
		m_terminal.WhenTitle  = [=](String s) { Title(m_title_prefix + " :: " + s); };
		m_terminal.WhenOutput = [=](String s) { m_pty.Write(s); };
		m_terminal.WhenResize = [=]()         {	m_pty.SetSize(m_terminal.GetPageSize()); };
	}

	int Run(const String& cmd)
	{
		if (!m_pty.Start(cmd.IsEmpty() ? GetEnv(tshell) : cmd, Environment(), GetHomeDirectory())) {
			ErrorOK("Failed to start shell process.");
			return -1;
		}

		OpenMain();
		PtyWaitEvent we;
		we.Add(m_pty, WAIT_READ | WAIT_IS_EXCEPTION);
		while(IsOpen() && m_pty.IsRunning()) {
			if(we.Wait(10))
				m_terminal.WriteUtf8(m_pty.Get());
			ProcessEvents();
		}

		return m_pty.GetExitCode();
	}

private:
	TerminalCtrl m_terminal;
	PtyProcess m_pty;

	const String m_title_prefix = "UppTerm";
};

GUI_APP_MAIN
{
	String cmd;
	
	const auto& args = CommandLine();
	if (args.GetCount() == 1) {
		cmd = args[0];
		cmd.TrimStart("\"");
		cmd.TrimEnd("\"");
	}

	SetExitCode(UppTerm().Run(cmd));
}
