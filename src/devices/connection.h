#ifndef CONNECTION_H
#define CONNECTION_H

#include "common/types.h"
#include "idevice.h"
#include "comms/icommunication.h"

#include <map>

namespace device
{

class Connection;
using ConnectionPtr = std::shared_ptr<Connection>;

using ConnectionMap = std::map<int, ConnectionPtr>;

// Connection object
class Connection
{
	friend class DeviceManager;

private:
	device::DevicePtr _device;
	int _number;
	bool _active;

public:
	Connection(const device::DevicePtr &device);
	~Connection();

public:
	static ConnectionPtr Make(const device::DevicePtr &device) { return std::make_shared<Connection>(device); }
	void Stop();
	device::DevicePtr GetDevice() const { return _device; }
	int Number() const { return _number; }
	bool IsActive() const { return _active; }
};

}

#endif // CONNECTION_H
