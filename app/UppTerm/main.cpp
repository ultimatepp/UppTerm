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
	UppTerm() {
		Title(m_title_prefix);
		Icon(UppTermImg::Icon());
		SetRect(m_terminal.GetStdSize());
		Sizeable().Zoomable().CenterScreen().Add(m_terminal.SizePos());
		
		m_terminal.WindowReports();
		m_terminal.WhenTitle = [=](String s) { Title(m_title_prefix + " :: " + s); };
	}
	
	void Close() override {
		if (m_pty.IsRunning()) {
			m_pty.Kill();
		}
	}
	
	int Run(const String& cmd)
	{
		m_terminal.WhenOutput = [&](String s) {
			m_pty.Write(s);
		};
		m_terminal.WhenResize = [&]() {
			m_pty.SetSize(m_terminal.GetPageSize());
		};
		
		m_pty.Start(cmd.IsEmpty() ? GetEnv(tshell) : cmd, Environment(), GetHomeDirectory());
		
		OpenMain();
		
		for(;;) {
			Ctrl::ProcessEvents();
			String s = m_pty.Get();
			int l = s.GetLength();
			m_terminal.WriteUtf8(s);
			if(!m_pty.IsRunning())
				break;
			Sleep(l >= 1024 ? 1024 * 10 / l : 10);
		}
		const auto exit_code = m_pty.GetExitCode();
		m_pty.Kill();
		return exit_code;
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
