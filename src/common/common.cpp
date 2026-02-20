#include "common.h"
#include "log.h"
#include "devicetypes.h"

#include <sys/stat.h>
#include <sys/time.h>
#include <libgen.h>
#include <limits.h>
#include <dirent.h>
#include <regex>

#include <Zipper/Unzipper.hpp>
using namespace zipper;

#ifdef WIN32
#include <windows.h>
#endif

namespace common
{

string CurrentTime()
{
	std::time_t time = std::time(NULL);
	char timeStr[50];
	std::strftime(timeStr, sizeof(timeStr), "%Y-%m-%d_%H-%M-%S", std::localtime(&time));
	return timeStr;
}

std::string currentTimeMs()
{
	static std::mutex timeMutex;
	std::lock_guard<std::mutex> lock(timeMutex);

	char timeStr[50];
	timeval tv;
	gettimeofday(&tv, NULL);
	std::time_t now = tv.tv_sec;
	struct tm *tm = std::localtime(&now);

	if (tm == nullptr)
		return CurrentTime();

	sprintf(timeStr, "%04d-%02d-%02d-%02d-%02d-%02d.%03d",
			tm->tm_year + 1900,
			tm->tm_mon + 1,
			tm->tm_mday,
			tm->tm_hour,
			tm->tm_min,
			tm->tm_sec,
			static_cast<int>(tv.tv_usec / 1000));

	return timeStr;
}

int64_t Timestamp()
{
	return std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
}

bool IsFileExists(const std::string &fileName)
{
	struct stat st;
	if (stat(fileName.c_str(), &st) == -1)
		return false;

	return true;
}

StringList GetComPorts()
{
	StringList ports;

#ifdef WIN32

	constexpr int keyValueSize = 4096;
	LONG lResult = ERROR_SUCCESS;
	DWORD dwIndex = 0;
	DWORD cbName = keyValueSize;
	char szSubKeyName[keyValueSize];

	HKEY hKey = nullptr;
	if (RegOpenKeyA(HKEY_LOCAL_MACHINE, "HARDWARE\\DEVICEMAP\\SERIALCOMM", &hKey) != ERROR_SUCCESS)
	{
		LOGE("Can't open registry key HARDWARE\\DEVICEMAP\\SERIALCOMM!");
		return ports;
	}

	BYTE szSubKeyValue[keyValueSize];
	DWORD dwValueSize = keyValueSize;
	while ((lResult = RegEnumValueA(hKey, dwIndex, szSubKeyName, &cbName, NULL, NULL, szSubKeyValue, &dwValueSize)) != ERROR_NO_MORE_ITEMS)
	{
		if (lResult == ERROR_SUCCESS)
			ports.push_back((char*)szSubKeyValue);

		cbName = keyValueSize;
		++dwIndex;
	}
#else
	//ttyUSB0 - radio module
	//ttyACM0 - pixhawk device

	DIR *dir = opendir("/dev");
	if (dir == NULL)
		return ports;

	struct dirent *entry;
	while ((entry = readdir(dir)) != NULL)
	{
		string device = entry->d_name;
		if (device.find(UART_NAME) == 0 || device.find(PIXHAWK_NAME) == 0)
			ports.push_back(device);
	}

	closedir(dir);

#endif

	return ports;
}

std::string GetCurrentDir()
{
#ifdef WIN32
#define GetCurDir _getcwd
#else
#include <unistd.h>
#define GetCurDir getcwd
#endif

	char buffer[FILENAME_MAX];
	GetCurDir(buffer, FILENAME_MAX);
	return string(buffer);
}

void CopyFile(const std::string &from, const std::string &to)
{
	std::ifstream source(from, std::ios::binary);
	std::ofstream dest(to, std::ios::binary);

	dest << source.rdbuf();

	source.close();
	dest.close();
}

void CreateDir(const std::string &dir)
{
#ifdef WIN32
	CreateDirectoryA(dir.c_str(), NULL);
#else
	mkdir(dir.c_str(), S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
#endif
}

bool Unzip(const string &fileName, const string &destDir)
{
	Unzipper unzipper(fileName);
	unzipper.extractAll(destDir, true);
	unzipper.close();
	return true;
}

StringList SplitString(const std::string &text, const std::string &separator)
{
	StringList list;

	char *nextToken = NULL;
	char *szTemp = strdup(text.c_str());

#ifdef WIN32
	char *szWord = strtok_s(szTemp, separator.c_str(), &nextToken);
#else
	char *szWord = strtok_r(szTemp, separator.c_str(), &nextToken);
#endif

	while (szWord != NULL)
	{
		list.push_back(szWord);

#ifdef WIN32
		szWord = strtok_s(NULL, separator.c_str(), &nextToken);
#else
		szWord = strtok_r(NULL, separator.c_str(), &nextToken);
#endif
	}

	delete szTemp;
	return list;
}

bool replace(std::string &str, const std::string &from, const std::string &to)
{
	str = std::regex_replace(str, std::regex(from), to);
	return true;
}

}
